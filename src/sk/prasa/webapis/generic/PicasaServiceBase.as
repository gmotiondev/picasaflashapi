/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.generic.ServiceBase;
import sk.prasa.webapis.generic.DynamicXMLService;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;

class sk.prasa.webapis.generic.PicasaServiceBase extends ServiceBase
{
	public static var PROGRESS:String 			= "progress";
	public static var IO_ERROR:String 			= "ioError";
	public static var SECURITY_ERROR:String 	= "securityError";
	
	public function getXMLService():DynamicXMLService
	{
		var service:DynamicXMLService = new DynamicXMLService();
			service.addEventListener(new EventType(PROGRESS), this, onProgress);
			service.addEventListener(new EventType(IO_ERROR), this, onIOError);
			service.addEventListener(new EventType(SECURITY_ERROR), this, onSecurityError);
		return service;
	}
	
	private function onIOError(event:IEvent):Void
	{
		dispatchEvent(event);
	}

	private function onSecurityError(event:IEvent):Void
	{
		dispatchEvent(event);
	}

	private function onProgress(event:IEvent):Void
	{
		dispatchEvent(event);
	}	
}