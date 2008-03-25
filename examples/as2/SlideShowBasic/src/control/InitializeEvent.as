/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.InitializeEvent extends BasicEvent
{
	public function InitializeEvent()
	{
		super(Controller.INITIALIZE_EVENT);
	}
}