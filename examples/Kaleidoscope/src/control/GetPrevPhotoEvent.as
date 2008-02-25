/**
 * @author michal.gron@gmail.com
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPrevPhotoEvent extends BasicEvent
{
	public function GetPrevPhotoEvent()
	{
		super(Controller.GET_PREV_PHOTO_EVENT);
	}
}