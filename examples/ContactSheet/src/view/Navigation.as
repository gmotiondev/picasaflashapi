import com.bourre.log.PixlibStringifier;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;
import com.bourre.events.IEvent;
import com.bourre.transitions.TweenMS;

import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Navigation extends MovieClipHelper
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
	
	public function onResize(e:IEvent):Void
	{
		centerize();
	}
	
	public function centerize():Void
	{
		move(Stage.width/2 - view._width/2, Stage.height - 60);
	}
	
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
//		var t:TweenMS = null;
//			t = new TweenMS(view, '_alpha', 0, 250, 100);
//			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
//			t.start();
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
