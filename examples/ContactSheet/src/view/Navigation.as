import com.bourre.log.PixlibStringifier;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;
import com.bourre.events.IEvent;

import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;

	/**
	 * Constructor	 */
	public function Navigation(sID:String,aC:MovieClip)
	{
		super(sID,aC);
		container = aC.createEmptyMovieClip("nav",2);
		initialize();
	}
	
	/**
	 * initialize point	 */
	private function initialize():Void
	{
		hide();
		
		var tL = view.attachMovie("l","l",1000);
			tL._x = 0;
			tL._y = 0;
			tL.onRelease = Delegate.create(this, onPrevPhoto);
			
		var tR = view.attachMovie("r","r",1001);
			tR._x = tL._width + 5;
			tR._y = 0;
			tR.onRelease = Delegate.create(this, onNextPhoto);
				
		//show();
		centerize();
	}
	
	/**
	 * listen to model	 */
	public function onResize(e:IEvent):Void
	{
		centerize();
	}
	
	/**
	 * centerize navigation	 */
	public function centerize():Void
	{
		move(Stage.width/2 - view._width/2, Stage.height - 60);
	}
	
	/**
	 * dispatch events	 */
	public function onPrevPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_PREV_PHOTO));
	}
	
	public function onNextPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_NEXT_PHOTO));
	}
	
	/**
	 * Listen to model	 */
	public function OnClosePhoto(e:IEvent):Void
	{
		hide();
	}
	
	public function PhotoThumbClick(e:IEvent):Void
	{
		show();
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}
