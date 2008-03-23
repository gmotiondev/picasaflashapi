package view 
{
	import control.ProgressEvent;	
	import control.ResizeEvent;	
	
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class LoadingBar extends AbstractView 
	{
		private var l : Sprite;
		private var c : Number = 0xD40073;

		public function LoadingBar(owner : Plugin, name : String, mc : DisplayObjectContainer)
		{
			super( owner, name, mc );
			
			initialize();
		}
		
		private function initialize() : void
		{
			l = new Sprite();
			l.graphics.beginFill(c);
			l.graphics.drawRect(0, 0, (view as DisplayObjectContainer).stage.stageWidth, 2);
			l.graphics.endFill();
			
			(view as DisplayObjectContainer).addChild(l);
		}
		public function onProgress(evt : ProgressEvent) : void
		{
			setVisible(evt.percent < 100); 
			l.scaleX = 100 - evt.percent;
		}
			
		public function onResize(evt : ResizeEvent) : void
		{
			l.width = l.stage.stageWidth;
		}
	}
}
