/**
 * @author michal.gron@gmail.com
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetNextPhotoEvent extends BasicEvent
{
	public function GetNextPhotoEvent()
	{
		super(Controller.GET_NEXT_PHOTO_EVENT);
	}
}