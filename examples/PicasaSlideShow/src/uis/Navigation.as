import com.bourre.log.PixlibStringifier;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;import com.bourre.events.BasicEvent;

import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com) */
class uis.Navigation extends MovieClipHelper
{
	public var container:MovieClip;

	public function Navigation(sID:String,aC:MovieClip)
	{
		super(sID,aC);
		container = aC.createEmptyMovieClip("nav",2);
		initialize();
	}
	
	private function initialize():Void
	{
		var l:MovieClip = container.attachMovie("l","l",1002);
		var r:MovieClip = container.attachMovie("r","r",1003);
		
		l._x = 40; l._y = 40;
		r._x = 620; r._y = 40;
		
		l.onRelease = Delegate.create(this,onPrevPhoto);		r.onRelease = Delegate.create(this,onNextPhoto);
		
		show();
	}
	
	public function onPrevPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_PREV_PHOTO));
	}
	
	public function onNextPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_NEXT_PHOTO));
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify( this );
	}
}
