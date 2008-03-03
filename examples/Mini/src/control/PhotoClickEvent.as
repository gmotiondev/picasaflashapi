import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoClickEvent extends BasicEvent
{
	public var id : String;
	
	public function PhotoClickEvent(aId : String)
	{
		super(Controller.PHOTO_CLICK_EVENT);
		
		id = aId;
	}
}