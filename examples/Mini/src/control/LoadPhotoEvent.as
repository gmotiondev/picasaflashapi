import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.LoadPhotoEvent extends BasicEvent
{
	public var id : String;
	public var url : String;
	
	public function LoadPhotoEvent(aId : String, aUrl : String)
	{
		super(Controller.LOAD_PHOTO_EVENT);
		
		id = aId;
		url = aUrl;
	}
}
