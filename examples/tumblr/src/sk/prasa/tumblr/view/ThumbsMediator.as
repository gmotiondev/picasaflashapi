package sk.prasa.tumblr.view 
{
	import sk.prasa.tools.model.helpers.QueueLoader;
	import sk.prasa.tools.model.vo.PhotoVO;
	import sk.prasa.tools.view.ImageLoader;
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.model.ContentProxy;
	import sk.prasa.tumblr.model.vo.ToolTipVO;
	import sk.prasa.tumblr.view.components.ThumbView;
	import sk.prasa.tumblr.view.components.ThumbsView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;	

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
		 * 
		 */
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.CHANGE_THUMBS_EVENT,
					ApplicationFacade.CHANGE_PHOTO_EVENT];
		}
		
		/**
		 * 
		 */
		override public function handleNotification(note : INotification) : void
		{
			switch (note.getName())
			{
				case ApplicationFacade.CHANGE_THUMBS_EVENT:
				
				 	this.removeThumbs();
				 	
				 	var tQueueLoader : QueueLoader = new QueueLoader();
					var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
					var tPhotos : Array = tContentProxy.getEntries();

					for(var a : int = 0; a < tPhotos.length; a++)
					{
						var tEntry : PhotoVO = tPhotos[a] as PhotoVO;
						var tThumb : ThumbView = new ThumbView(tEntry.id, tEntry.thumb, tEntry.title);
							tThumb.addEventListener(ProgressEvent.PROGRESS, progress_Handler, false, 0, true);
							tThumb.addEventListener(Event.COMPLETE, complete_Handler, false, 0, true);
							
						tQueueLoader.add(tThumb);
					}
					
					tQueueLoader.run();
					
					break;
					
				case ApplicationFacade.CHANGE_PHOTO_EVENT:
				
					this.highlightThumb(note.getBody() as String);
					
					break;
			}
		}
		
		/**
		 * add thumb to the ThumbsView layout manager
		 */
		protected function addThumb(thumb : ThumbView) : void
		{
			thumb.addEventListener(MouseEvent.CLICK, click_Handler, false, 0, true);
			thumb.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_Handler, false, 0, true);
			thumb.addEventListener(MouseEvent.MOUSE_OUT, mouseOut_Handler, false, 0, true);
			
			thumb.removeEventListener(ProgressEvent.PROGRESS, progress_Handler);
			thumb.removeEventListener(Event.COMPLETE, complete_Handler);
				
			this.thumbs.addChild(thumb);
		}
		
		/**
		 * remove the thumb from the layout manager
		 */
		protected function removeThumb(thumb : ThumbView) : void
		{
			thumb.removeEventListener(MouseEvent.CLICK, click_Handler);
			thumb.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver_Handler);
			thumb.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_Handler);
				
			this.thumbs.removeChild(thumb);
		}
		
		protected function removeThumbs() : void
		{	
			for(var a : int = this.thumbs.numChildren - 1; a >= 0; a--)
			{
				this.removeThumb(this.thumbs.getChildAt(a) as ThumbView);
			}
		}
		
		/**
		 * 
		 */
		protected function highlightThumb(aID : String) : void
		{
			for(var a : int = this.thumbs.numChildren - 1; a >= 0; a--)
			{
				var tThumbView : ThumbView = this.thumbs.getChildAt(a) as ThumbView;
					tThumbView.highlight(tThumbView.id == aID);
			}
		}
		
		/**
		 * thumb is clicked. just send notification which thumb was clicked.
		 */
		private function click_Handler(evt : Event) : void
		{
			this.sendNotification(ApplicationFacade.CHANGE_PHOTO_EVENT, ThumbView(evt.target).id);
		}
		
		/**
		 * thumb loading is completed.
		 */
		private function complete_Handler(evt : Event) : void
		{
			this.addThumb(evt.target as ThumbView);
		}
		
		/**
		 * @private
		 */
		private function mouseOver_Handler(evt : MouseEvent) : void
		{
			var tVO : ToolTipVO = new ToolTipVO();
				tVO.position = new Point(evt.stageX, evt.stageY);
				tVO.text = ThumbView(evt.target).title;
			
			this.sendNotification(ApplicationFacade.THUMB_MOUSE_OVER, tVO);
		}		
		/**
		 * @private
		 */
		private function mouseOut_Handler(evt : MouseEvent) : void
		{	
			this.sendNotification(ApplicationFacade.THUMB_MOUSE_OUT);
		}
		
		/**
		 * thumb is loading. just send notification for the progress bar.
		 */
		private function progress_Handler(evt : ProgressEvent) : void
		{
			this.sendNotification(ApplicationFacade.PROGRESS_EVENT, Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
		}
		
		/**
		 * @private
		 */
		private function get thumbs() : ThumbsView
		{
			return viewComponent as ThumbsView;
		}
	}
}
