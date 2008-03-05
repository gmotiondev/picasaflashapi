import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.photo.PhotoGetPrevEvent;
import control.photo.PhotoGetNextEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

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
		
		l._x = 5; l._y = 5;
		r._x = 25; r._y = 5;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);		r.onRelease = Delegate.create(this, onNextPhoto);
	}
	
	private function onPrevPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent());
	}
	
	private function onNextPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
	}
}