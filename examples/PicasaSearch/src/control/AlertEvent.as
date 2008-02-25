/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.AlertEvent extends BasicEvent
{
	public var message:String;
	
	public static var TIMEOUT_MESSAGE:String = "Service has timed out!";
	public static var ERROR_MESSAGE:String = "Service has fatal errors!";
	
	public function AlertEvent(aMessage:String)
	{
		super(Controller.ALERT_EVENT);
		
		message = aMessage;
	}
}