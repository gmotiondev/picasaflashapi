/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;

import view.*;
import control.*;
import model.*;

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
		
		Controller.getInstance().initialize();
		
		var view_l:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip(ViewList.LOADING_BAR, 10010));
		var view_t:ThumbHolder = new ThumbHolder(ViewList.THUMB_HOLDER,mc.createEmptyMovieClip(ViewList.THUMB_HOLDER,5));
		var view_p:PhotoHolder = new PhotoHolder(ViewList.PHOTO_HOLDER,mc.createEmptyMovieClip(ViewList.PHOTO_HOLDER,10));
		var view_n:Navigation = new Navigation(ViewList.NAVIGATION,mc.createEmptyMovieClip(ViewList.NAVIGATION,20));
		
		var model:ModelApplication = new ModelApplication();
			model.addListener(view_t);
			model.addListener(view_n);
			model.addListener(view_l);
			model.addListener(view_p);
			model.initialize();
	}
			
	public function onResize():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ResizeEvent());
	}
	
	public function onKeyDown():Void
	{
		switch (Key.getCode())
		{
			case Key.RIGHT: EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent()); break ;
			case Key.LEFT :	EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPreviousEvent());	break;
		}
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc); 
	}
}