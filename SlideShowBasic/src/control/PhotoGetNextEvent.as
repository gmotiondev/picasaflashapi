/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoGetNextEvent extends BasicEvent
{
	public function PhotoGetNextEvent()
	{
		super(Controller.PHOTO_GET_NEXT_EVENT);
	}
}
