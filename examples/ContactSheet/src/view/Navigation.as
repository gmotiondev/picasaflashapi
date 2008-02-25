import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com) */
class view.Navigation extends MovieClipHelper
{
	public function Navigation(sID:String,aC:MovieClip)
	{
		super(sID,aC);
		
		initialize();
	}
	
	private function initialize():Void
	{
		var l:MovieClip = view.attachMovie("l","l",1002);
		var r:MovieClip = view.attachMovie("r","r",1003);
		
		l._x = 0; l._y = 0;
		r._x = l._width + 5; r._y = 0;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);		r.onRelease = Delegate.create(this, onNextPhoto);
				
		centerize();
	}
		
	private function onPrevPhoto():Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPreviousEvent());
	}
	
	private function onNextPhoto():Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
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
		move(Math.round((Stage.width - view._width)/2), Stage.height - 60);
	}
}
