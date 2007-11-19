/** * Deprecated, will be deleted */ import com.bourre.events.IEvent;import com.bourre.data.libs.LibEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */ 
interface Picasa.IService
{	public function notifyChanged(e:IEvent):Void;	public function send():Boolean		public function onServiceLoaded(e:IEvent):Void	public function onServiceInit(e:LibEvent):Void;	public function onServiceProgress(e:LibEvent):Void	public function onServiceTimeout(e:LibEvent):Void	public function onServiceError(e:LibEvent):Void
}