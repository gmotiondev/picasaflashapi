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
		
		private var __width : Number;
		private var __height : Number;
		
		private var __font : uint;
		private var __background : uint;
		
		public function TitleView(width : Number, height : Number, font : uint, background : uint)
		{
			super();
			
			__width = width;
			__height = height;
			
			__font = font;
			__background = background;
			
			Style.LABEL_TEXT = __font;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler, false, 0, true);
		}
		
		private function addedToStage_Handler(evt : Event) : void
		{
			__title = new Label(this, 0, 0, "");
			__width = this.stage.stageWidth;
			resize();
		}
		
		private function redraw() : void
		{
			this.graphics.clear();
			this.graphics.beginFill(__background);
			this.graphics.drawRect(0, 0, __width, __height);
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
			this.y = this.stage.stageHeight - __height;
			__title.y = -2;
		}
	}
}
