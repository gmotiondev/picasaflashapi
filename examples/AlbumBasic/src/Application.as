import com.bourre.utils.SosTracer;
import com.bourre.log.Logger;
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import model.*;

import view.LoadingBar;
import view.Navigation;
import view.ViewList;
import view.thumb.ThumbsHolder;
import view.photo.PhotosHolder;

import control.Controller;
import control.ResizeEvent;
import control.photo.PhotoGetNextEvent;
import control.photo.PhotoGetPrevEvent;

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
		Key.addListener(this);
		
		Logger.getInstance().addLogListener(SosTracer.getInstance());
		Controller.getInstance().initialize();

		var model : ModelApplication = new ModelApplication();
		
		var p_view : PhotosHolder = new PhotosHolder(ViewList.PHOTOS_HOLDER, mc.createEmptyMovieClip(ViewList.PHOTOS_HOLDER, 10));
		var t_view : ThumbsHolder = new ThumbsHolder(ViewList.THUMBS_HOLDER, mc.createEmptyMovieClip(ViewList.THUMBS_HOLDER, 20));
		var n_view : Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip(ViewList.NAVIGATION, 30));
		var l_view : LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip(ViewList.LOADING_BAR, 40));

		model.addListener(p_view);
		model.addListener(l_view);

		model.initialize(mc.userid, mc.albumid);
	}
	
	public function onResize() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}
	
	public function onKeyDown() : Void
	{
		switch (Key.getCode())
		{
			case Key.RIGHT: EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent()); break;
			case Key.LEFT : EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent()); break;
			default: break;
		}
	}
	
	public static function main(mc : MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o : Application = new Application(mc);
	}
}