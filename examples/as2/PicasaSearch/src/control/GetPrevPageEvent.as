/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPrevPageEvent extends BasicEvent
{
	public var tag:String;
	
	public function GetPrevPageEvent()
	{
		super(Controller.GET_PREV_PAGE_EVENT);
	}
}