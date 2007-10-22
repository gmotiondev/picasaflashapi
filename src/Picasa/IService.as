import com.bourre.events.IEvent;import com.bourre.data.libs.LibEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */ 
interface Picasa.IService
{
	public function onInitialize(e:LibEvent):Void;	public function notifyChanged(e:IEvent):Void;	
}