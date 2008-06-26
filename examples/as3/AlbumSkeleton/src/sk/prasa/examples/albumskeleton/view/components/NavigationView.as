package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.bit101.components.PushButton;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class NavigationView extends Sprite 
	{
		public static const SEND_REQUEST_EVENT : String = "send_request_event";
		
		public static const PREV_PAGE_EVENT : String = "prev_page_event";
		public static const NEXT_PAGE_EVENT : String = "next_page_event";
		
		public static const PREV_PHOTO_EVENT : String = "prev_photo_event";
		public static const NEXT_PHOTO_EVENT : String = "next_photo_event";
		
		public function NavigationView()
		{
			var tSend : PushButton = new PushButton(this, 0, 0, "get album content", onSendRequest);
				tSend.width = 100;
				
			var tPrevPage : PushButton = new PushButton(this, 100, 0, "<<", onPrevPage);
				tPrevPage.width = 20;
				
			var tPrevPhoto : PushButton = new PushButton(this, 120, 0, "<", onPrevPhoto);
				tPrevPhoto.width = 20;
				
			var tNextPhoto : PushButton = new PushButton(this, 140, 0, ">", onNextPhoto);
				tNextPhoto.width = 20;
				
			var tNextPage : PushButton = new PushButton(this, 160, 0, ">>", onNextPage);
				tNextPage.width = 20;
		}
		
		private function onSendRequest(evt : Event) : void
		{
			dispatchEvent(new Event(SEND_REQUEST_EVENT));
		}
		
		private function onPrevPage(evt : Event) : void
		{
			dispatchEvent(new Event(PREV_PAGE_EVENT));
		}
		
		private function onNextPage(evt : Event) : void
		{
			dispatchEvent(new Event(NEXT_PAGE_EVENT));
		}
		
		private function onPrevPhoto(evt : Event) : void
		{
			dispatchEvent(new Event(PREV_PHOTO_EVENT));
		}
		
		private function onNextPhoto(evt : Event) : void
		{
			dispatchEvent(new Event(NEXT_PHOTO_EVENT));
		}
	}
}
