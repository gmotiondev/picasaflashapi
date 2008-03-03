import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.ProgressEvent extends BasicEvent
{
	public var percent : Number;
	
	public function ProgressEvent(p : Number)
	{
		super(Controller.PROGRESS_EVENT);
		
		percent = p;
	}
}