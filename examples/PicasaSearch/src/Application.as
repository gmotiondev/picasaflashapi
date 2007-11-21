import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;

import view.*;
import control.*;
import model.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClipHelper
{
	/**
	 *	Constructor
	 */
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		initialize(mc);
	}
	
	/**
	 *	initialize point
	 */	
	private function initialize(mc:MovieClip):Void
	{
		Stage.addListener(this);
		Key.addListener(this);
		
		Controller.getInstance().initialize();
		
		var view_l:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip(ViewList.LOADING_BAR, 10010));
		var view_t:ThumbHolder = new ThumbHolder(ViewList.THUMB_HOLDER,mc.createEmptyMovieClip(ViewList.THUMB_HOLDER,5));
		var view_n:Navigation = new Navigation(ViewList.NAVIGATION,mc.createEmptyMovieClip(ViewList.NAVIGATION,20));
		
		var model:ModelApplication = new ModelApplication();
			model.addListener(view_t);
			model.addListener(view_n);
			model.addListener(view_l);
			model.initialize();
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc); 
	}
}