/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.ProgressSetEvent extends BasicEvent
{
	public var percent:Number;
	
	public function ProgressSetEvent(p:Number)
	{
		super(Controller.PROGRESS_SET_EVENT);
		
		percent = p;
	}
}