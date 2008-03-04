import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Navigation extends MovieClipHelper
{
	public function Navigation(name : String, mc : MovieClip)
	{
		super(name, mc);
		initialize();
	}
	
	private function initialize() : Void
	{
		var c : MovieClip = view.attachMovie("c", "c", 1001);
		var l : MovieClip = view.attachMovie("l", "l", 1002);
		var r : MovieClip = view.attachMovie("r", "r", 1003);
		var q : MovieClip = view.attachMovie("q", "q", 1004);
		
		c._x = 0; c._y = 0;
		l._x = c._x + c._width + 30; l._y = 0;
		r._x = l._x + l._width + 10; r._y = 0;
		q._x = r._x + r._width + 30; q._y = 0;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);
		r.onRelease = Delegate.create(this, onNextPhoto);
		
		c.onRelease = Delegate.create(this, onChoose);
		q.onRelease = Delegate.create(this, onClose);
		
		centerize();
	}
		
	private function onPrevPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent());
	}
	
	private function onNextPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
	}
	
	private function onChoose() : Void
	{
		FSCommand2("quit");
	}
	
	private function onClose() : Void
	{
	
	}
	
	private function centerize() : Void
	{
		move(Math.round((Stage.width - view._width)/2), Stage.height - 20);
	}
}