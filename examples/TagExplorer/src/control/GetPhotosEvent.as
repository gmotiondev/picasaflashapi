/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPhotosEvent extends BasicEvent
{
	public var tag:String;
	
	public function GetPhotosEvent(aTag:String)
	{
		super(Controller.GET_PHOTOS_EVENT);
		tag = aTag;
	}
}