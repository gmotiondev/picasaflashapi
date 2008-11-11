package sk.prasa.tumblr.view 
{
	import sk.prasa.tools.model.vo.PhotoVO;
	import sk.prasa.tools.view.ImageLoader;
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.model.ContentProxy;
	import sk.prasa.tumblr.view.components.AlbumView;
	import sk.prasa.tumblr.view.components.PhotoView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;	

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
			return [ApplicationFacade.CHANGE_THUMBS_EVENT,
					ApplicationFacade.CHANGE_PHOTO_EVENT,
					ApplicationFacade.RESIZE_EVENT];
		}

		override public function handleNotification(note : INotification) : void
		{
			switch (note.getName())
			{
				case ApplicationFacade.CHANGE_THUMBS_EVENT: // Loads first photo. Doesn't have an ID, but we will retrieve it from content proxy.
				case ApplicationFacade.CHANGE_PHOTO_EVENT:
				
					var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
					var tID : String = note.getBody() as String;
					var tPhotoVO : PhotoVO = tContentProxy.getEntry(tID);
					
					var tPhoto : PhotoView = new PhotoView(tPhotoVO.id, tPhotoVO.url);
						tPhoto.addEventListener(ProgressEvent.PROGRESS, progress_Handler, false, 0, true);
						tPhoto.addEventListener(Event.COMPLETE, complete_Handler, false, 0, true);
						tPhoto.load();
						
					this.sendNotification(ApplicationFacade.PROGRESS_EVENT, 1);	//just to display progress bar on next or prev click.. 
					this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, tPhotoVO.title);
					
					break;
					
				case ApplicationFacade.FULLSCREEN_EVENT:
				case ApplicationFacade.RESIZE_EVENT:
					this.album.dispatchEvent(new Event(Event.RESIZE));
					break;
			}
		}
		
		private function addPhoto(photo : PhotoView) : void
		{
			this.removePhotos();
			
			var tPhoto : PhotoView = photo;
				tPhoto.addEventListener(MouseEvent.CLICK, click_Handler, false, 0, true);
				tPhoto.removeEventListener(ProgressEvent.PROGRESS, progress_Handler);
				tPhoto.removeEventListener(Event.COMPLETE, complete_Handler);
				
			this.album.addChild(tPhoto);
		}
		
		private function removePhoto(photo : PhotoView) : void
		{
			photo.removeEventListener(MouseEvent.CLICK, click_Handler);
			
			this.album.removeChild(photo);
		}
		
		private function removePhotos() : void
		{
			for(var a : int = this.album.numChildren - 1; a >= 0; a--)
			{
				this.removePhoto(this.album.getChildAt(a) as PhotoView);
			}
		}
		
		private function click_Handler(evt : Event) : void
		{
		}
		
		private function complete_Handler(evt : Event) : void
		{
			this.addPhoto(evt.target as PhotoView);
		}
		
		private function progress_Handler(evt : ProgressEvent) : void
		{
			this.sendNotification(ApplicationFacade.PROGRESS_EVENT, Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
		}

		private function get album() : AlbumView
		{
			return viewComponent as AlbumView;
		}
	}
}
