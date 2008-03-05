import com.bourre.events.BasicEvent;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.ResizeEvent extends BasicEvent
{
	public function ResizeEvent()
	{
		super(Controller.RESIZE_EVENT);
	}
}