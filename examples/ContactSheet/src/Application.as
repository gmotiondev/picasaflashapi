import com.bourre.utils.SosTracer;
import com.bourre.log.Logger;
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import control.*;
import control.photo.*;
import model.*;
import view.*;
import view.photo.*;
import view.thumb.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Application extends MovieClipHelper
{
	private function Application(mc : MovieClip)
	{
		super(ViewList.APPLICATION_VIEW, mc);
		
		initialize(mc);
	}
	
	private function initialize(mc : MovieClip) : Void
	{
		Stage.addListener(this);
		Key.addListener(this);
		
		Logger.getInstance().addLogListener(SosTracer.getInstance());
		Controller.getInstance().initialize();
		
		var view_l : LoadingBar = new LoadingBar(ViewList.LOADING_BAR_VIEW, mc.createEmptyMovieClip(ViewList.LOADING_BAR_VIEW, 10010));
		var view_n : Navigation = new Navigation(ViewList.NAVIGATION_VIEW, mc.createEmptyMovieClip(ViewList.NAVIGATION_VIEW, 20));
		var view_t : ThumbsView = new ThumbsView(ViewList.THUMBS_VIEW, mc.createEmptyMovieClip(ViewList.THUMBS_VIEW, 5));
		var view_p : PhotosView = new PhotosView(ViewList.PHOTOS_VIEW, mc.createEmptyMovieClip(ViewList.PHOTOS_VIEW, 10));
				
		var model : ModelApplication = new ModelApplication();
			model.addListener(view_t);
			model.addListener(view_n);
			model.addListener(view_l);
			model.addListener(view_p);
			
			model.initialize(mc["userid"], mc["albumid"]);
	}
			
	public function onResize() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}
	
	public function onKeyDown() : Void
	{
		switch (Key.getCode())
		{
			case Key.RIGHT : EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent()); break ;
			case Key.LEFT :	EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent());	break;
		}
	}
	
	public static function main(mc : MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o : Application = new Application(mc);	
		delete o;
	}
}