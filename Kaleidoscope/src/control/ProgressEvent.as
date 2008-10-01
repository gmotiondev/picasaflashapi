/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.ProgressEvent extends BasicEvent
{
	public var percent:Number;
	
	public function ProgressEvent(p:Number)
	{
		super(Controller.PROGRESS_EVENT);
		
		percent = p;
	}
}