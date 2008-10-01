/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.page.GetNextPageEvent extends BasicEvent
{
	public function GetNextPageEvent()
	{
		super(Controller.GET_NEXT_PAGE_EVENT);
	}
}