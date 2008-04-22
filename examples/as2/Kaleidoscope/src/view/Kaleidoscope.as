import com.bourre.data.collections.Map;
import com.bourre.events.IEvent;
import com.bourre.visual.MovieClipHelper;

import control.*;
import view.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.Kaleidoscope extends MovieClipHelper
{	
	private var __c : Map;

	public function Kaleidoscope(aId : String, aContainer : MovieClip)
	{
		super(aId, aContainer);
		
		__c = new Map();
	}
	
	private function addChild(aId : String, aUrl : String) : Void
	{
		var tPhoto : MovieClipHelper = new Photo(aId, view.createEmptyMovieClip("p_" + aId, view.getNextHighestDepth()), aUrl);
			__c.put(aId, aId);

		this._getBroadcaster().addListener(tPhoto);
	}
	
	public function notifyChanged(evt : IEvent) : Void
	{
		this._getBroadcaster().broadcastEvent(evt);
	}

	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		var tID : String = "" + evt.id;
		var tURL : String = "" + evt.url;
		
		if(!__c.containsKey(tID))
		{
			addChild(tID, tURL);
		}
		
		notifyChanged(evt);
	}
}
