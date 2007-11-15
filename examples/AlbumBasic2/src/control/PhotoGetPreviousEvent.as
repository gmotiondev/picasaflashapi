/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoGetPreviousEvent extends BasicEvent
{
	public function PhotoGetPreviousEvent()
	{
		super(Controller.PHOTO_GET_PREV_EVENT);
	}
}