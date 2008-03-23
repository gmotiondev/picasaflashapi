package  
{
	import control.ResizeEvent;	
	
	import com.bourre.events.EventBroadcaster;	
	
	import flash.display.StageAlign;	
	import flash.display.StageScaleMode;	
	import flash.events.Event;	
	import flash.display.DisplayObject;	
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;	
	
	import view.ViewList;	
	import view.LoadingBar;	
	import view.Navigation;	
	import view.thumb.ThumbsHolder;	
	import view.photo.PhotosHolder;	
	import model.ModelApplication;
	import control.Controller;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Application extends Sprite 
	{
		public function Application()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(Event.ACTIVATE, initialize);
		}
		
		private function initialize(evt : Event) : void
		{			
			Controller.getInstance().initialize();
			
			var tModel : ModelApplication = new ModelApplication();
			
			var p_view : PhotosHolder = new PhotosHolder(null, ViewList.PHOTOS_HOLDER, this);
			var t_view : ThumbsHolder = new ThumbsHolder(null, ViewList.THUMBS_HOLDER, this);
			var n_view : Navigation = new Navigation(null, ViewList.NAVIGATION, this);
			var l_view : LoadingBar = new LoadingBar(null, ViewList.LOADING_BAR, this);
			
			tModel.addListener(p_view);
			tModel.addListener(t_view);
			tModel.addListener(n_view);
			tModel.addListener(l_view);
			
			tModel.initialize();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		private function resizeHandler(evt : Event) : void 
		{
			EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
        }
	}
}
