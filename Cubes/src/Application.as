/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.log.Logger;
import com.bourre.utils.SosTracer;
import com.bourre.visual.MovieClipHelper;

import control.*;
import model.*;
import view.*;

class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{
		Logger.getInstance().addLogListener( SosTracer.getInstance());
		Stage.addListener(this);
		
		Controller.getInstance().initialize();
		
		var view_m:MainView = new MainView(ViewList.MAIN_VIEW, mc.createEmptyMovieClip(ViewList.MAIN_VIEW, 5));
		var view_u:UserView = new UserView(ViewList.USER_VIEW, mc.createEmptyMovieClip(ViewList.USER_VIEW, 10));
		
		var model:ModelApplication = new ModelApplication();
			model.addListener(view_m);
			model.addListener(view_u);
			model.initialize();
	}
	
	public function onResize() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}

	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
		delete o;
	}
}