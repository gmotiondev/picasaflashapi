/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import control.Controller;

class control.ChangeEvent extends BasicEvent
{
	public var property:String;
	public var data:Object;
	
	public function ChangeEvent(p:String,d:Object)
	{
		super(Controller.CHANGE_EVENT);
		
		property = p;
		data = d;
	}
}