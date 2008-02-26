import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import model.*;
import view.*;
import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * @see based on http://www.quasimondo.com/archives/000579.php
 */
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
		
		Controller.getInstance().initialize();
		
		var view_l:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip(ViewList.LOADING_BAR, 10010));
		var view_k:Kaleidoscope = new Kaleidoscope(ViewList.KALEIDOSCOPE, mc.createEmptyMovieClip(ViewList.KALEIDOSCOPE, 20));
		var view_n:Navigation = new Navigation(ViewList.NAVIGATION,mc.createEmptyMovieClip(ViewList.NAVIGATION,30));
				
		var model:ModelApplication = new ModelApplication();
			model.addListener(view_l);
			model.addListener(view_k);
			model.addListener(view_n);
			
			model.initialize();
	}
	
	public function onResize():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
}