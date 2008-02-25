/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import sk.prasa.visual.object.AbstractThumb;

import control.*;

class view.Thumb extends AbstractThumb
{
	private var title:String;
	private var id:String;
	
	public function Thumb(aId:String, aContainer:MovieClip, aTitle:String)
	{
		super(aId, aContainer, aTitle);
		
		setBackground(0xffffff, 0xe2007a, 4);
		view.onRelease = Delegate.create(this, onThumbRelease);
	}
	
	// dispatch event to command the model.. 
	private function onThumbRelease():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new PhotoClickEvent(id));
	}
	
	// listen to the model
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		setHighlight(evt.id == id);
	}
}
