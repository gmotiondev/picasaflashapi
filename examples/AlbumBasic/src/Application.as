/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import model.*;
import view.*;
import control.*;

class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{
		Stage.addListener(this);
		Key.addListener(this);
		
		/* model */
		var model:ModelApplication = new ModelApplication();
		
		/* views */
		var p_view:PhotoHolder= new PhotoHolder(ViewList.PHOTO_HOLDER, 	mc.createEmptyMovieClip(ViewList.PHOTO_HOLDER, 	10));
		var t_view:ThumbHolder= new ThumbHolder(ViewList.THUMB_HOLDER, 	mc.createEmptyMovieClip(ViewList.THUMB_HOLDER, 	20));
		var n_view:Navigation = new Navigation(ViewList.NAVIGATION, 	mc.createEmptyMovieClip(ViewList.NAVIGATION, 	30));
		var l_view:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, 	mc.createEmptyMovieClip(ViewList.LOADING_BAR, 	40));

		/* controller */
		Controller.getInstance().initialize();
		model.addListener(p_view);
		model.addListener(l_view);
		model.container = mc;
		model.initialize();	
	}
	
	public function onResize():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ScreenResizeEvent());
	}
	
	public function onKeyDown():Void
	{
		var code:Number = Key.getCode() ;
		switch (code)
		{
			case Key.RIGHT :
				EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
				break ;
			case Key.LEFT :
				EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPreviousEvent());
				break ;
			default: break;
		}
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
}