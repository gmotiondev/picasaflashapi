/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.ResizeEvent extends BasicEvent
{
	public function ResizeEvent()
	{
		super(Controller.RESIZE_EVENT);
	}
}