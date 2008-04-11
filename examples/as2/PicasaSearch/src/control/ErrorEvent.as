import control.Controller;

import com.bourre.events.BasicEvent;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.ErrorEvent extends BasicEvent 
{
	public var message : String;

	public function ErrorEvent(aMessage : String)
	{
		super(Controller.ERROR_EVENT);
		
		message = aMessage;
	}
}
