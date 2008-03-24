package  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import com.bourre.events.EventBroadcaster;
	
	import control.*;
	import control.photo.PhotoGetNextEvent;
	import control.photo.PhotoGetPrevEvent;
	
	import model.ModelApplication;
	
	import view.*;
	import view.photo.*;
	import view.thumb.*;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[SWF(width="320", height="260", backgroundColor="0xffffff", frameRate="31")]
	public class Application extends Sprite 
	{
		[Embed(source="../assets/ttf/kr_08_53.ttf", fontName="kroeger", mimeType="application/x-font-truetype")]
		private static var KROEGER_FONT : String;
	
		public function Application()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
	          
			initialize();
		}
		
		private function initialize() : void
		{			
			Controller.getInstance().initialize();

			var tModel : ModelApplication = new ModelApplication();
			
			var p_view : PhotosHolder = new PhotosHolder(null, ViewList.PHOTOS_HOLDER, addChild(new Sprite()));
			var t_view : ThumbsHolder = new ThumbsHolder(null, ViewList.THUMBS_HOLDER, addChild(new Sprite()));
			var n_view : Navigation = new Navigation(null, ViewList.NAVIGATION, addChild(new Sprite()));
			var l_view : LoadingBar = new LoadingBar(null, ViewList.LOADING_BAR, addChild(new Sprite()));
			
			tModel.addListener(p_view);
			tModel.addListener(t_view);
			tModel.addListener(n_view);
			tModel.addListener(l_view);
			
			tModel.initialize();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		private function resizeHandler(evt : Event) : void 
		{
			EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
        }
        
        private function keyboardHandler(evt : KeyboardEvent) : void 
		{
			switch(evt.keyCode)
			{
				case Keyboard.RIGHT: EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent()); break;
				case Keyboard.LEFT : EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent()); break;
				default: break;
			}
        }
	}
}
