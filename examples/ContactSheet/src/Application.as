import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;

import view.ViewList;
import view.PhotoHolder;
import view.ThumbHolder;
import view.Navigation;
import view.LoadingBar;
import control.Controller;
import model.ModelApplication;
import events.EventList;

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
		
		var tLB:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip("loadingBar",10010));
		
		Controller.getInstance().initialize();
		
		var tThumbHolder:ThumbHolder = new ThumbHolder(ViewList.THUMBS,mc.createEmptyMovieClip("thumbholder",5));
		var tPhotoHolder:PhotoHolder = new PhotoHolder(ViewList.PHOTO,mc.createEmptyMovieClip("photoholder",10));
		var tNavigation:Navigation = new Navigation(ViewList.NAVIGATION,mc.createEmptyMovieClip("navigation",20));
		
		var model:ModelApplication = new ModelApplication();
			model.addListener(tThumbHolder);
			model.addListener(tNavigation);
			model.setContainer(mc);
			model.initialize();
	}
	
	/**
	 *	Listen to Stage resize
	 */		
	public function onResize():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_RESIZE));
	}
	
	/**
	 * Invoked when the user press a key.
	 */
	public function onKeyDown():Void
	{
		var code:Number = Key.getCode() ;
		switch (code)
		{
			case Key.RIGHT :
			{
				EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_NEXT_PHOTO));
				break ;
			}
			case Key.LEFT :
			{
				EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_PREV_PHOTO));
				break ;
			}
		}	
	}
	
	/**
	 *	mtasc entry point
	 */
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
	
	/**
	 *	pixlib 
	 */	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}