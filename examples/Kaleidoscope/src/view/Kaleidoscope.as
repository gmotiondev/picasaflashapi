/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.data.collections.Map;
import control.*;
import view.Photo;

class view.Kaleidoscope extends MovieClipHelper
{	
	private var __children:Map;
	private var __oEB:EventBroadcaster;
	
	public function Kaleidoscope(aId:String, aContainer:MovieClip)
	{
		super(aId, aContainer);
		
		__children = new Map();
	}
	
	public function notifyChanged(evt:IEvent):Void
	{
		_oEB.broadcastEvent(evt);
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		trace("photo_changed_event: "+evt.id);
		
		if(!__children.containsKey(evt.id))
		{
			var tPhoto:Photo = new Photo(evt.id, view.createEmptyMovieClip("p_"+evt.id, view.getNextHighestDepth()), evt.url);
			__children.put(evt.id, tPhoto);
			addListener(tPhoto);
		}
		
		notifyChanged(evt);
	}
}