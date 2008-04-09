import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.page.GetPrevPageEvent extends BasicEvent
{
	public function GetPrevPageEvent()
	{
		super(Controller.GET_PREV_PAGE_EVENT);
	}
}