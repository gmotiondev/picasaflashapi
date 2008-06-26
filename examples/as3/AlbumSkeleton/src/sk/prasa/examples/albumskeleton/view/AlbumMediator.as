package sk.prasa.examples.albumskeleton.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.model.ContentProxy;
	import sk.prasa.examples.albumskeleton.model.vo.PhotoVO;
	import sk.prasa.examples.albumskeleton.view.components.AlbumView;
	import sk.prasa.examples.albumskeleton.view.components.PhotoView;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "AlbumMediator";
		
		public function AlbumMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
		}

		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.CHANGE_PHOTO_EVENT];
		}

		override public function handleNotification(notification : INotification) : void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.CHANGE_PHOTO_EVENT:
				
					var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
					var tID : String = notification.getBody() as String;
					var tPhotoVO : PhotoVO = tContentProxy.getEntry(tID);
					
					var tPhoto : PhotoView = new PhotoView(tPhotoVO.id, tPhotoVO.url);
						tPhoto.addEventListener(ProgressEvent.PROGRESS, onProgress);
						tPhoto.addEventListener(Event.COMPLETE, onPhotoComplete);
						
					this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, tPhotoVO.title);
					
				break;
			}
		}
		
		
		private function addPhoto(aPhoto : PhotoView) : void
		{
			var tPhoto : PhotoView = aPhoto;
				tPhoto.addEventListener(MouseEvent.CLICK, onPhotoClick);
				tPhoto.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				tPhoto.removeEventListener(Event.COMPLETE, onPhotoComplete);
				
			this.album.addChild(tPhoto);
		}
		
		private function removePhoto(aPhoto : PhotoView) : void
		{
			var tPhoto : PhotoView = aPhoto;
				tPhoto.removeEventListener(MouseEvent.CLICK, onPhotoClick);
				
			this.album.removeChild(tPhoto);
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

		private function get album() : AlbumView
		{
			return viewComponent as AlbumView;
		}
	}
}
