import com.bourre.events.BasicEvent;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.PhotoChangedEvent extends BasicEvent
{
	public var id : String;
	public var url : String;

	public function PhotoChangedEvent(aId : String, aUrl : String)
	{
		super(Controller.PHOTO_CHANGED_EVENT);
		
		id = aId;
		url = aUrl;
	}
}