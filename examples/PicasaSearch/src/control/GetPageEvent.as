/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;

import control.Controller;

class control.GetPageEvent extends BasicEvent
{
	public var direction:String
	
	public function GetPageEvent(aDirection:String)
	{
		super(Controller.GET_PAGE_EVENT);
		direction = aDirection;
	}
}