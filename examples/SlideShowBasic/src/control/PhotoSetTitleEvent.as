/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.PhotoSetTitleEvent extends BasicEvent
{
	public var title:String;
	
	public function PhotoSetTitleEvent(t:String)
	{
		super(Controller.PHOTO_SET_TITLE_EVENT);
		
		title = t;
	}
}