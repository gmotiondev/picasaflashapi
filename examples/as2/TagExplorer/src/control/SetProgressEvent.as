/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.SetProgressEvent extends BasicEvent
{
	public var percent:Number;
	
	public function SetProgressEvent(p:Number)
	{
		super(Controller.SET_PROGRESS_EVENT);
		
		percent = p;
	}
}