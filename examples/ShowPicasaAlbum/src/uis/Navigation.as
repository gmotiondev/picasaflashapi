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
		var tLMC = container.createEmptyMovieClip("l",1000);
			tLMC._x = 690;
			tLMC._y = 5;
			tLMC.createTextField("left_arrow",10,0,0,50,20);
			tLMC["left_arrow"].html = true;			tLMC["left_arrow"].htmlText = "<font face=\"Tahoma\">&lt; Prev</font>";
			tLMC.onRelease = Delegate.create(this,onPrevPhoto);
				var tRMC = container.createEmptyMovieClip("r",1001);
			tRMC._x = 740;
			tRMC._y = 5;
			tRMC.createTextField("right_arrow",10,0,0,50,20);
			tRMC["right_arrow"].html = true;			tRMC["right_arrow"].htmlText = "<font face=\"Tahoma\">Next &gt;</font>";
			tRMC.onRelease = Delegate.create(this,onNextPhoto);
		
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
