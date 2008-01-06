import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;import com.bourre.transitions.TweenMS;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com) */
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
	private var __message:MovieClip;
	
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
		
		l._x = 0; l._y = 0;
		r._x = l._width + 5; r._y = 0;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);		r.onRelease = Delegate.create(this, onNextPhoto);
				
		centerize();
	}
		
	private function onPrevPhoto():Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPreviousEvent());
		protect();
	}
	
	private function onNextPhoto():Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
		protect();
	}
	
	/**
	 * listen to model
	 */
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
	
	private function centerize():Void
	{
		move(Stage.width/2 - view._width/2, Stage.height - 60);
	}
	
	private function protect():Void
	{
		container.r.onRelease = container.l.onRelease = null;
		
		var t:TweenMS = null;
			t = new TweenMS(null, '_alpha', 0, 500, 0);
			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, unprotect);
			t.start();
	}
	
	private function unprotect():Void
	{
		container.l.onRelease = Delegate.create(this, onPrevPhoto);
		container.r.onRelease = Delegate.create(this, onNextPhoto);
	}
}
