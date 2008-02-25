/**
 * @author michal.gron@gmail.com
 */
import com.bourre.events.BasicEvent;

import control.Controller;

class control.PhotoClickEvent extends BasicEvent
{
	public var id:String;
	
	public function PhotoClickEvent(aId:String)
	{
		super(Controller.PHOTO_CLICK_EVENT);
		
		id = aId;
	}
}