package sk.prasa.examples.albumskeleton.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import com.yahoo.astra.layout.LayoutContainer;
	import com.yahoo.astra.layout.modes.FlowLayout;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.model.ContentProxy;
	import sk.prasa.examples.albumskeleton.model.vo.PhotoVO;
	import sk.prasa.examples.albumskeleton.model.vo.RequestVO;
	import sk.prasa.examples.albumskeleton.view.components.AlbumView;
	import sk.prasa.examples.albumskeleton.view.components.ImageLoaderView;
	import sk.prasa.examples.albumskeleton.view.components.PhotoView;
	import sk.prasa.examples.albumskeleton.view.components.ThumbView;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "AlbumMediator";
		
		private var thumbs : LayoutContainer;
		private var photos : DisplayObjectContainer;

		public function AlbumMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
			
			var tThumbsLayoutMode : FlowLayout = new FlowLayout();
				tThumbsLayoutMode.horizontalGap = 2;
				tThumbsLayoutMode.verticalGap = 2;
			
			thumbs = new LayoutContainer(tThumbsLayoutMode);
			thumbs.width = 360;
			
			this.holder.addChild(thumbs);
			 
			photos = this.holder.addChild(new Sprite()) as Sprite;
			
			this.holder.addEventListener(AlbumView.GET_ALBUM_CONTENT_EVENT, sendRequest);
		}

		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.DATA_EVENT];
		}

		override public function handleNotification(notification : INotification) : void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.DATA_EVENT:
				
					var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy; 
					var tPhotos : Array = tContentProxy.getEntries();
					
					for(var a : int = 0;a < tPhotos.length; a++)
					{
						var tPhoto : PhotoVO = tPhotos[a] as PhotoVO;
						var tThumb : ThumbView = new ThumbView(tPhoto.id, tPhoto.thumb);
							tThumb.addEventListener(ProgressEvent.PROGRESS, onProgress);
							tThumb.addEventListener(Event.COMPLETE, onThumbComplete);
					}
					
					break;
			}
		}
		
		private function sendRequest(evt : Event) : void
		{
			var tRequestVO : RequestVO = new RequestVO();
				tRequestVO.userid = "thisispinkfu";
				tRequestVO.albumid = "5094406297232552993";
			
			this.sendNotification(ApplicationFacade.LOAD_EVENT, tRequestVO);
		}

		private function addThumb(aThumb : ThumbView) : void
		{
			var tThumb : ThumbView = aThumb;
				tThumb.addEventListener(MouseEvent.CLICK, onThumbClick);
				tThumb.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				tThumb.removeEventListener(Event.COMPLETE, onThumbComplete);
				
			this.thumbs.addChild(tThumb);
		}

		private function removeThumb(aThumb : ThumbView) : void
		{
			var tThumb : ThumbView = aThumb;
				tThumb.removeEventListener(MouseEvent.CLICK, onThumbClick);
				
			this.thumbs.removeChild(tThumb);
		}

		private function addPhoto(aPhoto : PhotoView) : void
		{
			var tPhoto : PhotoView = aPhoto;
				tPhoto.addEventListener(MouseEvent.CLICK, onPhotoClick);
				tPhoto.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				tPhoto.removeEventListener(Event.COMPLETE, onPhotoComplete);
				
			this.photos.addChild(tPhoto);
		}

		private function removePhoto(aPhoto : PhotoView) : void
		{
			var tPhoto : PhotoView = aPhoto;
				tPhoto.removeEventListener(MouseEvent.CLICK, onPhotoClick);
				
			this.photos.removeChild(tPhoto);
		}
		
		private function onThumbComplete(evt : Event) : void
		{
			this.addThumb(evt.target as ThumbView);
		}
		
		private function onThumbClick(evt : Event) : void
		{
			var tID : String = ThumbView(evt.target).id;
			var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
			var tPhotoVO : PhotoVO = tContentProxy.getEntry(tID);
			
			var tPhoto : PhotoView = new PhotoView(tPhotoVO.id, tPhotoVO.url);
				tPhoto.addEventListener(ProgressEvent.PROGRESS, onProgress);
				tPhoto.addEventListener(Event.COMPLETE, onPhotoComplete);
		}
		
		private function onPhotoComplete(evt : Event) : void
		{
			this.addPhoto(evt.target as PhotoView);
		}
		
		private function onPhotoClick(evt : Event) : void
		{
			this.removePhoto(PhotoView(evt.target));
		}
		
		private function onProgress(evt : ProgressEvent) : void
		{
			this.sendNotification(ApplicationFacade.PROGRESS_EVENT, Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
		}

		private function get holder() : AlbumView
		{
			return viewComponent as AlbumView;
		}
	}
}
