package sk.prasa.tumblr.view.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ToolTipView extends Sprite 
	{	
		private var __tf : TextField;

		public static var FOLLOW_MOUSE : Boolean = true;
		public static var BACKGROUND_COLOR : uint = 0xE2007A;
		public static var COLOR : uint = 0xFFFFFF;
		
		public function ToolTipView()
		{
			super();
		}
		
		public function draw(point : Point, text : String) : void
		{
			if(text == null)
			{
				return;
			}
			
			this.clear();
			
			if(!FOLLOW_MOUSE)
			{
				this.x = point.x;
				this.y = point.y;
			} else
			{
				this.stage.addEventListener(MouseEvent.MOUSE_MOVE, move, false, 0, true);
			}
			
			if(!__tf)
			{
				__tf = new TextField();
				__tf.autoSize = "left";
				__tf.embedFonts = true;
				__tf.background = true;
				__tf.backgroundColor = BACKGROUND_COLOR;
				__tf.defaultTextFormat = new TextFormat("PF Ronda Seven", 8, COLOR);
				__tf.text = "" + text;
					
				this.addChild(__tf);
			} else
			{
				__tf.visible = true;
			}
		}
		
		public function clear() : void
		{
			if(__tf)
			{
				if(FOLLOW_MOUSE && this.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
				{ 
					this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, move);
				}
				
				__tf.visible = false;
				//trace(__tf, __tf.parent);
				//this.removeChild(__tf);
			}
		}
		
		private function move(evt : MouseEvent) : void
		{
			var tOffset : Point = new Point(0, -20);
				
			if((evt.stageX + this.width) > this.stage.stageWidth)
			{
				tOffset.x -= this.width;
			}
			
			this.x = evt.stageX + tOffset.x;
			this.y = evt.stageY + tOffset.y;
		}
	}
}
