import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.thumb.ThumbClickEvent extends BasicEvent
{
	public var id : String;
	
	public function ThumbClickEvent(aId : String)
	{
		super(Controller.THUMB_CLICK_EVENT);
		
		id = aId;
	}
}