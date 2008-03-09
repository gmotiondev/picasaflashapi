import com.bourre.events.BasicEvent;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.InitializeEvent extends BasicEvent
{
	public function InitializeEvent()
	{
		super(Controller.INITIALIZE_EVENT);
	}
}