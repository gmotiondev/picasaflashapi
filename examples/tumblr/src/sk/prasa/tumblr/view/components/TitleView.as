package sk.prasa.tumblr.view.components
{
	import com.bit101.components.Label;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class TitleView extends Sprite 
	{
		private var __title : Label;
		
		public static var COLOR : uint = 0xFFFFFF;
		
		public function TitleView()
		{
			super();
			
			Style.LABEL_TEXT = COLOR;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler, false, 0, true);
		}
		
		private function addedToStage_Handler(evt : Event) : void
		{
			__title = new Label(this, 0, 0, "");
			
			resize();
		}
		
		private function redraw() : void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xCC0066);
			this.graphics.drawRect(	0, 0, 
									this.stage.stageWidth, NavigationView.NAVIGATION_HEIGHT);
			this.graphics.endFill();
		}
		
		public function set text(value : String) : void
		{
			__title.text = value != null ? value : "";
		}

		public function get text() : String
		{
			return __title.text;
		}
		
		public function resize() : void
		{
			redraw();
			
			this.x = 0;
			this.y = this.stage.stageHeight - NavigationView.NAVIGATION_HEIGHT;
			__title.y = -2;
		}
	}
}
