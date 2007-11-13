/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

class sk.prasa.webapis.generic.events.ServiceEvent extends BasicEvent
{	
	private var __data:Object = {};

	// 
	public function ServiceEvent(type:EventType)
	{
		super(type);
	}
	
	public function get data():Object
	{
		return __data;
	}
	
	public function set data(o:Object):Void
	{
		__data = o;
	}
	
	public function get type():EventType
	{
		return super.getType();
	}
	
	public function set type(e:EventType):Void
	{
		super.setType(e);
	}
	
	public function get target():Object
	{
		return super.getTarget();
	}
	
	public function set target(o:Object):Void
	{
		super.setTarget(o);
	}
	
	// 
	public function toString():String
	{
		return "[ServiceEvent type="+type.toString()+" target="+target.toString()+"]";
	}
}