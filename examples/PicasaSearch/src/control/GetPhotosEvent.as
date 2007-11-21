/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPhotosEvent extends BasicEvent
{
	public var query:String;
	
	public function GetPhotosEvent(q:String)
	{
		super(Controller.GET_PHOTOS_EVENT);
		query = q;
	}
}