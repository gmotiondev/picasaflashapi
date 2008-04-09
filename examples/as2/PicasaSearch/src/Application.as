import com.bourre.utils.LuminicTracer;
import com.bourre.log.Logger;
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import model.*;
import view.*;
import view.dialog.*;
import view.thumb.*;
import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Application extends MovieClipHelper
{
	private function Application(mc : MovieClip)
	{
		super(ViewList.APPLICATION, mc);
	
		initialize(mc);
	}

	private function initialize(mc : MovieClip) : Void
	{
		Stage.addListener(this);
		Logger.getInstance().addLogListener(LuminicTracer.getInstance());
		Controller.getInstance().initialize();
	
		var view_l : LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip(ViewList.LOADING_BAR, 10010));
		var view_t : ThumbsHolder = new ThumbsHolder(ViewList.GRID, mc.createEmptyMovieClip(ViewList.GRID, 20));
		var view_n : Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip(ViewList.NAVIGATION, 30));
		var view_d : SearchDialog = new SearchDialog(ViewList.SEARCH_DIALOG, mc.createEmptyMovieClip(ViewList.SEARCH_DIALOG, 40));
				
		var model : ModelApplication = new ModelApplication();
		model.addListener(view_t);
		model.addListener(view_n);
		model.addListener(view_l);
		model.addListener(view_d);
			
		model.initialize();
	}

	public function onResize() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}

	public static function main(mc : MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o : Application = new Application(mc);
		delete o;
	}
}