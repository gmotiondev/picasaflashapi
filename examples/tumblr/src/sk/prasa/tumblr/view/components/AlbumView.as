package sk.prasa.tumblr.view.components 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gs.TweenLite;		
	
	/**
	 * AlbumView, holds all the photos as PhotoView.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class AlbumView extends Sprite 
	{	
		public function AlbumView()
		{
			super();
			
			this.addEventListener(Event.RESIZE, resize_Handler, false, 0, true);
		}
		
		override public function addChild(child : DisplayObject) : DisplayObject
		{
			var tChild : DisplayObject = super.addChild(child);
				tChild.alpha = 0;
				
				centerize();
				
			TweenLite.to(tChild, 0.5, {alpha : 1});
			
			return tChild;
		}
		
		private function centerize() : void
		{
			this.x = (this.stage.stageWidth - this.width) / 2;
			this.y = (this.stage.stageHeight - this.height) / 2;
		}
		
		private function resize_Handler(evt : Event) : void
		{
			centerize();
		}
	}
}
