package sk.prasa.examples.albumskeleton.view 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
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
		
		private var thumbs : DisplayObjectContainer;
		private var photos : DisplayObjectContainer;

		public function AlbumMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
			
			thumbs = this.holder.addChild(new Sprite()) as Sprite;
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
						
						this.addThumb(tThumb);
					}
					
					break;
			}
		}

		private function addThumb(aThumb : ThumbView) : void
		{
			// handle layout?
			var tThumb : ThumbView = aThumb;
				tThumb.addEventListener(ThumbView.THUMB_CLICK_EVENT, onThumbClick);
			
			this.thumbs.addChild(tThumb);
		}
		
		private function removeThumb(aThumb : ThumbView) : void
		{
			// handle layout?
			var tThumb : ThumbView = aThumb;
				tThumb.removeEventListener(ThumbView.THUMB_CLICK_EVENT, onThumbClick);
			
			this.thumbs.removeChild(tThumb);
		}

		private function addPhoto(aPhoto : PhotoView) : void
		{
			// handle layout?
			var tPhoto : PhotoView = aPhoto;
				tPhoto.addEventListener(PhotoView.PHOTO_CLICK_EVENT, onPhotoClick);
			
			this.photos.addChild(tPhoto);
		}

		private function removePhoto(aPhoto : PhotoView) : void
		{
			// handle layout?
			var tPhoto : PhotoView = aPhoto;
				tPhoto.removeEventListener(PhotoView.PHOTO_CLICK_EVENT, onPhotoClick);
			
			this.photos.removeChild(tPhoto);
		}
		
		private function sendRequest(evt : Event) : void
		{
			var tRequestVO : RequestVO = new RequestVO();
				tRequestVO.userid = "thisispinkfu";
				tRequestVO.albumid = "5094406297232552993";
			
			this.sendNotification(ApplicationFacade.LOAD_EVENT, tRequestVO);
		}
		
		private function onThumbClick(evt : Event) : void
		{
			var tID : String = ThumbView(evt.target).id;
			var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
			var tPhotoVO : PhotoVO = tContentProxy.getEntry(tID);
			
			this.addPhoto(new PhotoView(tPhotoVO.id, tPhotoVO.url));
		}

		private function onPhotoClick(evt : Event) : void
		{
			this.removePhoto(PhotoView(evt.target));
		}
		
		private function get holder() : AlbumView
		{
			return viewComponent as AlbumView;
		}
	}
}
