import model.ModelApplication;

import control.Controller;

import com.bourre.utils.SosTracer;
import com.bourre.log.Logger;
import com.bourre.visual.MovieClipHelper;

import view.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Simple picasa browser for mobile phones
 * loads album with thumbnails (with paging)
 * loads just one photo, then unload, then next and so on
 */
class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		
		initialize(mc);
	}
	
	private function initialize(mc : MovieClip) : Void
	{
		//Logger.getInstance().addLogListener(SosTracer.getInstance());
		
		Controller.getInstance().initialize();
		
		var view_l : LoadingBar = new LoadingBar(ViewList.LOADINGBAR, mc.createEmptyMovieClip(ViewList.LOADINGBAR, 10010));
		var view_t : Thumbs = new Thumbs(ViewList.THUMBSVIEW, mc.createEmptyMovieClip(ViewList.THUMBSVIEW, 5));
		var view_p : PhotoView = new PhotoView(ViewList.PHOTOVIEW, mc.createEmptyMovieClip(ViewList.PHOTOVIEW, 10));
		var view_n : Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip(ViewList.NAVIGATION, 20));
		
		var model : ModelApplication = new ModelApplication();
			model.addListener(view_l);
			model.addListener(view_t);
			model.addListener(view_p);
			model.addListener(view_n);
			
			model.initialize();
	}

	public static function main(mc : MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o : Application = new Application(mc);
		delete o;
	}
}