/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoChangedEvent extends BasicEvent
{
	public var id:String;
	
	public function PhotoChangedEvent(pid:String)
	{
		super(Controller.PHOTO_CHANGED_EVENT);
		
		id = pid;
	}
}
