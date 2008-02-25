/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoChangedEvent extends BasicEvent
{
	public var id:String;
	public var title:String;
	
	public function PhotoChangedEvent(aId:String, aTitle:String)
	{
		super(Controller.PHOTO_CHANGED_EVENT);
		
		id = aId;
		title = aTitle;
	}
}
