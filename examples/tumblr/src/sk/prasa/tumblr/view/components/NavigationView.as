package sk.prasa.tumblr.view.components 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;		

	/**
	 * Navigation view. 
	 * Holds the prev/next photo links
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 */
	public class NavigationView extends Sprite 
	{	
		public static const PREV_PHOTO_EVENT : String = "prev_photo_event";
		public static const NEXT_PHOTO_EVENT : String = "next_photo_event";
		public static const NAVIGATION_WIDTH : Number = 14;
		public static const NAVIGATION_HEIGHT : Number = 14;
		
		private var __prevButton : PushButton;
		private var __nextButton : PushButton;
		
		public function NavigationView()
		{
			super();
			
			Style.BACKGROUND = 0x9B0054;
			Style.BUTTON_FACE = 0xE2007A;
			Style.LABEL_TEXT = 0xFFFFFF;
			Style.DROPSHADOW = 0xE2007A;
				
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler, false, 0, true);
		}
		
		/**
		 * @private
		 */
		private function addedToStage_Handler(evt : Event) : void
		{
			__prevButton = new PushButton(this, 0, 0, "<", prevPhoto_Handler);
			__prevButton.width = NAVIGATION_WIDTH; 
			__prevButton.height = NAVIGATION_HEIGHT;
				
			__nextButton = new PushButton(this, 0, 0, ">", nextPhoto_Handler);
			__nextButton.width = NAVIGATION_WIDTH; 
			__nextButton.height = NAVIGATION_HEIGHT;
			
			resize();
			
			this.stage.addEventListener(KeyboardEvent.KEY_UP, key_Handler, false, 0, true);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler);
		}
		
		public function resize() : void
		{
			this.x = 0;
			this.y = this.stage.stageHeight - NavigationView.NAVIGATION_HEIGHT;
			
			__prevButton.move(this.stage.stageWidth - 2 * NAVIGATION_HEIGHT, 0);
			__nextButton.move(this.stage.stageWidth - NAVIGATION_HEIGHT, 0);
		}
		
		/**
		 * @private
		 */
		private function key_Handler(evt : KeyboardEvent) : void
		{
			switch(evt.keyCode)
			{
				case Keyboard.LEFT: dispatchEvent(new Event(PREV_PHOTO_EVENT)); break;	// arrow left
				case Keyboard.RIGHT: dispatchEvent(new Event(NEXT_PHOTO_EVENT)); break;	// arrow right
			}
		}
		
		/**
		 * @private
		 */
		private function prevPhoto_Handler(evt : Event) : void
		{
			dispatchEvent(new Event(PREV_PHOTO_EVENT));
		}
		
		/**
		 * @private
		 */
		private function nextPhoto_Handler(evt : Event) : void
		{
			dispatchEvent(new Event(NEXT_PHOTO_EVENT));
		}
	}
}
