package view 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import control.ProgressEvent;
	import control.ResizeEvent;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class LoadingBar extends AbstractView
	{
		private var l : Sprite;

		public function LoadingBar(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc );

			initialize();
		}
		
		private function initialize() : void
		{
			l = new Sprite();
			l.graphics.beginFill(0xffffff);
			l.graphics.drawRect(0, 0, 10, 2);
			l.graphics.endFill();
			
			(view as DisplayObjectContainer).addChild(l);
		}
		
		public function onProgress(evt : ProgressEvent) : void
		{
			l.visible = (evt.percent < 100);
			l.scaleX = 100 - evt.percent;
		}
			
		public function onResize(evt : ResizeEvent) : void
		{
			l.width = l.stage.stageWidth;
		}
	}
}
