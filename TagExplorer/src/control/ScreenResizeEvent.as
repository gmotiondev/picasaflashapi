/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.ScreenResizeEvent extends BasicEvent
{
	public function ScreenResizeEvent()
	{
		super(Controller.SCREEN_RESIZE_EVENT);
	}
}