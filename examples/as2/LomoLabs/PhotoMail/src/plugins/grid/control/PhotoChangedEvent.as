/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.events.BasicEvent;

import plugins.grid.control.Controller;

class plugins.grid.control.PhotoChangedEvent extends BasicEvent
{
	public var id:String;
	public var summary:String;
	
	public function PhotoChangedEvent(aId:String, aSummary:String)
	{
		super(Controller.PHOTO_CHANGED_EVENT);
		
		id = aId;
		summary = aSummary;
	}	
}
