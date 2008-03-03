import control.PhotoClickEvent;
import control.PhotoChangedEvent;

import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;
import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Thumb extends MovieClipHelper
{
	private var id : String;

	public function Thumb(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		view.onRelease = Delegate.create(this, onThumbRelease);
	}
	
	private function onThumbRelease() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new PhotoClickEvent(id));
	}
	
	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		// highlight?
	}
}
