/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import view.NavigationView;
import view.PhotoView;
import view.ThumbsView;

import view.ViewList;
import control.Controller;
import view.LoadingBarView;
import model.MiniLiteModel;

import com.bourre.utils.SosTracer;
import com.bourre.log.Logger;

class Application extends MovieClip
{
	private function Application(mc : MovieClip)
	{
		Logger.getInstance().addLogListener(SosTracer.getInstance());
		
		trace("MiniLite up and running!");

		var tModel : MiniLiteModel = new MiniLiteModel();
		var tControl : Controller = new Controller(tModel);
		
		var view_l : LoadingBarView = new LoadingBarView(	tModel, tControl, mc.createEmptyMovieClip(ViewList.LOADING_BAR_VIEW, 10010));
		var view_t : ThumbsView 	= new ThumbsView(		tModel, tControl, mc.createEmptyMovieClip(ViewList.THUMBS_VIEW, 5));
		var view_p : PhotoView 		= new PhotoView(		tModel, tControl, mc.createEmptyMovieClip(ViewList.PHOTO_VIEW, 10));
		var view_n : NavigationView = new NavigationView(	tModel, tControl, mc.createEmptyMovieClip(ViewList.NAVIGATION_VIEW, 20));
		
		tModel.addObserver(view_l);		tModel.addObserver(view_t);		tModel.addObserver(view_p);		tModel.addObserver(view_n);
		
		tModel.initialize();
	}

	public static function main(mc : MovieClip) : Void
	{
		var o : Application = new Application(mc);
			delete o;
	}
}
