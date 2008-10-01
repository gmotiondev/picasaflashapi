import com.bourre.events.BasicEvent;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.photo.PhotoChangedEvent extends BasicEvent
{
	public var id : String;
	public var title : String;
	
	public function PhotoChangedEvent(aId : String, aTitle : String)
	{
		super(Controller.PHOTO_CHANGED_EVENT);
		
		id = aId;
		title = aTitle;
	}
}