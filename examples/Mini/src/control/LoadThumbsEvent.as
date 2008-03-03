import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.LoadThumbsEvent extends BasicEvent
{
	public function LoadThumbsEvent()
	{
		super(Controller.LOAD_THUMBS_EVENT);
	}
}