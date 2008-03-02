/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoGetPrevEvent extends BasicEvent
{
	public function PhotoGetPrevEvent()
	{
		super(Controller.PHOTO_GET_PREV_EVENT);
	}
}