/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetNextPageEvent extends BasicEvent
{
	public var tag:String;
	
	public function GetNextPageEvent()
	{
		super(Controller.GET_NEXT_PAGE_EVENT);
	}
}