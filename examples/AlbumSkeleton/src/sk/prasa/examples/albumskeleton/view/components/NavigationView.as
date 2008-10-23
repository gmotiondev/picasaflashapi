package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;		
	
	/**
	 * Navigation view. 
	 * Holds the prev/next photo links and prev/next page links 
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 */
	public class NavigationView extends Sprite 
	{	
		public static const PREV_PAGE_EVENT : String = "prev_page_event";
		public static const NEXT_PAGE_EVENT : String = "next_page_event";
		
		public static const PREV_PHOTO_EVENT : String = "prev_photo_event";
		public static const NEXT_PHOTO_EVENT : String = "next_photo_event";
		
		public function NavigationView()
		{			
			this.addEventListener(Event.ADDED_TO_STAGE, initializeKeyboard);
		}
		
		private function initializeKeyboard(evt : Event) : void
		{
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyUp(evt : KeyboardEvent) : void
		{
			switch(evt.keyCode)
			{
				case 37: dispatchEvent(new Event(PREV_PHOTO_EVENT)); break;	// arrow left				case 39: dispatchEvent(new Event(NEXT_PHOTO_EVENT)); break;	// arrow right				case 38: dispatchEvent(new Event(PREV_PAGE_EVENT)); break;	// arrow up				case 40: dispatchEvent(new Event(NEXT_PAGE_EVENT)); break;	// arrow down
			}
		}
	}
}
