import com.bourre.events.IEvent;
import com.bourre.events.EventType;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.generic.events.ServiceEvent implements IEvent
{	
	private var __o : Object = {};
	private var __t : EventType;
	 
	public function ServiceEvent(t : EventType, o : Object)
	{
		__t = t;
		__o = o;
	}
	
	public function getType() : EventType
	{ 
		return __t; 
	}
	
	public function setType(t : EventType) : Void 
	{ 
		__t = t; 
	}
	
	public function getTarget()
	{ 
		return __o; 
	}
	
	public function setTarget(o) : Void 
	{ 
		__o = o; 
	}
	
	public function get data() : Object
	{
		return __o;
	}
	
	public function set data(o : Object) : Void
	{
		__o = o;
	}
	
	public function get type() : EventType
	{
		return getType();
	}
	
	public function set type(t : EventType):Void
	{
		setType(t);
	}
	
	public function get target() : Object
	{
		return getTarget();
	}
	
	public function set target(o : Object):Void
	{
		setTarget(o);
	}
	
	public function toString() : String
	{
		return "[ServiceEvent type=" + getType().toString() + " target=" + getTarget().toString() + "]";
	}
}