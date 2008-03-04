import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.ThumbClickEvent extends BasicEvent
{
	public var id : String;
	
	public function ThumbClickEvent(aId : String)
	{
		super(Controller.THUMB_CLICK_EVENT);
		
		id = aId;
	}
}
