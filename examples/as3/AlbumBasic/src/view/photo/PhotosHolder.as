package view.photo 
{
	import flash.display.DisplayObjectContainer;	
	import flash.display.Sprite;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosHolder extends AbstractView 
	{
		public function PhotosHolder(owner : Plugin, name : String, mc : DisplayObjectContainer)
		{
			super( owner, name, mc );
			
			initialize();
		}
		
		private function initialize() : void
		{
			var tRec : Sprite = new Sprite();
				tRec.graphics.beginFill(0x00ff00);
				tRec.graphics.drawRect(10, 10, 10, 10);
				tRec.graphics.endFill();
				
			(view as DisplayObjectContainer).addChild(tRec);
			//view.addChild(tRec);
		}
	}
}
