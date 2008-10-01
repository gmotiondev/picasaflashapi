/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;

import plugins.grid.control.Controller;

class plugins.grid.control.PhotoClosedEvent extends BasicEvent
{
	public var id:String;
	
	public function PhotoClosedEvent()
	{
		super(Controller.PHOTO_CLOSED_EVENT);
	}
}