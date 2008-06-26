package sk.prasa.examples.albumskeleton.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.model.ContentProxy;
	import sk.prasa.examples.albumskeleton.model.vo.PhotoVO;
	import sk.prasa.examples.albumskeleton.view.components.ThumbView;
	import sk.prasa.examples.albumskeleton.view.components.ThumbsView;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ThumbsMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "ThumbsMediator";
		
		public function ThumbsMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
		}
		
		/**
		 * We are interested only when new thumbs arived, only if the DATA_EVENT occurs 
		 * 
		 */
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.DATA_EVENT];
		}
		
		/**
		 * If the DATA_EVENT occurs, the ContentProxy holds actual informations about photos.
		 * We retrieve all the entries from the ContentProxy.
		 * For each entry we create a ThumbView (extends Loader). If the thumb is loaded, we add it to
		 * the ThumbsView (extends LayoutManager).
		 */
		override public function handleNotification(notification : INotification) : void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.DATA_EVENT:
				 	// TODO: ... remove all thumbs first!
				 	var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
					var tPhotos : Array = tContentProxy.getEntries();
					
					for(var a : int = 0;a < tPhotos.length; a++)
					{
						var tEntry : PhotoVO = tPhotos[a] as PhotoVO;
						var tThumb : ThumbView = new ThumbView(tEntry.id, tEntry.thumb);
							tThumb.addEventListener(ProgressEvent.PROGRESS, onProgress);
							tThumb.addEventListener(Event.COMPLETE, onThumbComplete);
					}
					
					break;
			}
		}
		
		/**
		 * add thumb to the ThumbsView layout manager
		 */
		protected function addThumb(aThumb : ThumbView) : void
		{
			var tThumb : ThumbView = aThumb;
				tThumb.addEventListener(MouseEvent.CLICK, onThumbClick);
				tThumb.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				tThumb.removeEventListener(Event.COMPLETE, onThumbComplete);
				
			this.thumbs.addChild(tThumb);
		}
		/**
		 * remove the thumb from the layout manager
		 */
		protected function removeThumb(aThumb : ThumbView) : void
		{
			var tThumb : ThumbView = aThumb;
				tThumb.removeEventListener(MouseEvent.CLICK, onThumbClick);
				
			this.thumbs.removeChild(tThumb);
		}
		
		/**
		 * thumb is clicked. just send notification which thumb was clicked.
		 */
		private function onThumbClick(evt : Event) : void
		{
			this.sendNotification(ApplicationFacade.CHANGE_PHOTO_EVENT, ThumbView(evt.target).id);
		}
		
		/**
		 * thumb loading is completed.
		 */
		private function onThumbComplete(evt : Event) : void
		{
			this.addThumb(evt.target as ThumbView);
		}
		
		/**
		 * thumb is loading. just send notification for the progress bar.
		 */
		private function onProgress(evt : ProgressEvent) : void
		{
			this.sendNotification(ApplicationFacade.PROGRESS_EVENT, Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
		}
		
		private function get thumbs() : ThumbsView
		{
			return viewComponent as ThumbsView;
		}
	}
}
