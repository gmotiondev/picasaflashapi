/**
 *
 */
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import control.Controller;

class control.GetTagsEvent extends BasicEvent
{
	public var username:String;
	
	public function GetTagsEvent(aUsername:String)
	{
		super(Controller.GET_TAGS_EVENT);
		username = aUsername;
	}
}