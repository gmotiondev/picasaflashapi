package view.thumb 
{
	import flash.display.DisplayObjectContainer;	
	import flash.display.Sprite;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ThumbsHolder extends AbstractView 
	{
		public function ThumbsHolder(owner : Plugin, name : String, mc : DisplayObjectContainer)
		{
			super( owner, name, mc );
			
			initialize();
		}
		
		private function initialize() : void
		{
			var tRec : Sprite = new Sprite();
				tRec.graphics.beginFill(0xffff00);
				tRec.graphics.drawRect(30, 10, 10, 10);
				tRec.graphics.endFill();
				
			(view as DisplayObjectContainer).addChild(tRec);
		}
	}
}
