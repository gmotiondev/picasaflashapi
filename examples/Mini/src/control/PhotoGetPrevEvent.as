import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoGetPrevEvent extends BasicEvent
{
	public function PhotoGetPrevEvent()
	{
		super(Controller.PHOTO_GET_PREV_EVENT);
	}
}
