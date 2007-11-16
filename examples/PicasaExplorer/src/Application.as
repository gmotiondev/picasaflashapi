/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;

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
		/* model */
		var model:ModelApplication = new ModelApplication();
		
		//var p_view:PhotoHolder= new PhotoHolder(ViewList.PHOTO_HOLDER, 	mc.createEmptyMovieClip(ViewList.PHOTO_HOLDER, 	10));
		//var t_view:ThumbHolder= new ThumbHolder(ViewList.THUMB_HOLDER, 	mc.createEmptyMovieClip(ViewList.THUMB_HOLDER, 	20));
		//var n_view:Navigation = new Navigation(ViewList.NAVIGATION, 	mc.createEmptyMovieClip(ViewList.NAVIGATION, 	30));
		//var l_view:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, 	mc.createEmptyMovieClip(ViewList.LOADING_BAR, 	40));
		
		var main_view:MainView = new MainView(ViewList.MAIN_VIEW, mc.createEmptyMovieClip(ViewList.MAIN_VIEW, 50));
		
		/* controller */
		Controller.getInstance().initialize();
		//model.addListener(p_view);
		model.initialize();	
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
}