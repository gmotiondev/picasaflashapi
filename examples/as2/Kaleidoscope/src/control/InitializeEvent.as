/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.InitializeEvent extends BasicEvent
{
	public var userid:String;
	public var tag:String;
	
	public function InitializeEvent(aUserid:String, aTag:String)
	{
		super(Controller.INITIALIZE_EVENT);
		
		userid = aUserid;
		tag = aTag;
	}
}