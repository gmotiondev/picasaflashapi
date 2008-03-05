import com.bourre.events.BasicEvent;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.photo.PhotoGetNextEvent extends BasicEvent
{
	public function PhotoGetNextEvent()
	{
		super(Controller.PHOTO_GET_NEXT_EVENT);
	}
}
