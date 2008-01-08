/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPageEvent extends BasicEvent
{
	public var page_number:Number;
	
	public function GetPageEvent(aPageNumber:Number)
	{
		super(Controller.GET_PAGE_EVENT);
		page_number = aPageNumber;
	}
}