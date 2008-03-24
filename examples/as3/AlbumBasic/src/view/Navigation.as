package view 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import control.photo.PhotoGetNextEvent;
	import control.photo.PhotoGetPrevEvent;		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Navigation extends AbstractView 
	{
		[Embed(source="../../assets/library.swf", symbol="l")]
		private var LeftArrow : Class;
		
		[Embed(source="../../assets/library.swf", symbol="r")]
		private var RightArrow : Class;
		
		public function Navigation(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc);
			
			initialize();
		}
		
		private function initialize() : void
		{
			var l : Sprite = new LeftArrow();
			var r : Sprite = new RightArrow();
			
			(view as DisplayObjectContainer).addChild(l);
			(view as DisplayObjectContainer).addChild(r);
			
			l.x = 5; l.y = 5;
			r.x = 25; r.y = 5;
			
			l.addEventListener(MouseEvent.CLICK, onPrevPhoto);
			r.addEventListener(MouseEvent.CLICK, onNextPhoto);			
		}
		
		private function onPrevPhoto(evt : MouseEvent) : void
		{	
			EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent());
		}
		
		private function onNextPhoto(evt : MouseEvent) : void
		{	
			EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
		}
	}
}
