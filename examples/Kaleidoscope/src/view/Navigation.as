/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;
import com.bourre.visual.MovieClipHelper;

import control.*;

class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
		
	public function Navigation(aID:String,aMC:MovieClip)
	{
		super(aID,aMC);
		
		initialize();
	}

	private function initialize():Void
	{
		Key.addListener(this);
		
		var l:MovieClip = view.attachMovie("l", "l", 1002);
		var r:MovieClip = view.attachMovie("r", "r", 1003);
		
		l.onRelease = Delegate.create(this, onPrevPhoto);
		r.onRelease = Delegate.create(this, onNextPhoto);
		
		centerize();	
	}
	
	private function onPrevPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPrevPhotoEvent());
	}
	
	private function onNextPhoto():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetNextPhotoEvent());
	}
	
	private function centerize():Void
	{
		view.l._x = 20;
		view.l._y = Stage.height - view.l._height - 20;
		
		view.r._x = Stage.width - view.r._width - 20;
		view.r._y = Stage.height - view.r._height - 20;
	}
	
	public function onKeyDown():Void
	{
		switch(Key.getCode())
		{
			case Key.RIGHT: onNextPhoto(); break;
			case Key.LEFT: onPrevPhoto(); break;
			default: break;
		}
	}
	
	public function resize_event(evt:ResizeEvent):Void
	{
		centerize();
	}
}