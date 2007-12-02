/**
 *
 */
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import control.Controller;

class control.SetPhotosEvent extends BasicEvent
{	
	public function SetPhotosEvent()
	{
		super(Controller.SET_PHOTOS_EVENT);
	}
}