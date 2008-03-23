package view.thumb 
{
	import com.bourre.load.LoaderEvent;	
	import com.bourre.load.LoaderListener;	
	
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;	
	import flash.display.Sprite;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ThumbsHolder extends AbstractView implements LoaderListener
	{
		public function ThumbsHolder(owner : Plugin, name : String, mc : DisplayObjectContainer)
		{
			super( owner, name, mc );
			
			initialize();
		}
		
		public function addChild(child : DisplayObject) : DisplayObject
		{
			return (view as DisplayObjectContainer).addChild(child);
		}

		private function initialize() : void
		{
			var tRec : Sprite = new Sprite();
				tRec.graphics.beginFill(0xffff00);
				tRec.graphics.drawRect(30, 10, 10, 10);
				tRec.graphics.endFill();
				
			(view as DisplayObjectContainer).addChild(tRec);
		}
		
		public function onLoadStart( e : LoaderEvent ) : void
		{
		}
		
		public function onLoadInit( e : LoaderEvent ) : void
		{
			trace("onLoadInit: " + e.getName());
		}
		
		public function onLoadProgress( e : LoaderEvent ) : void
		{
		}
		
		public function onLoadTimeOut( e : LoaderEvent ) : void
		{
		}
		
		public function onLoadError( e : LoaderEvent ) : void
		{
		}
	}
}
