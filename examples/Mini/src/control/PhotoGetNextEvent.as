import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoGetNextEvent extends BasicEvent
{
	public function PhotoGetNextEvent()
	{
		super(Controller.PHOTO_GET_NEXT_EVENT);
	}
}
