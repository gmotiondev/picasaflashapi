import sk.prasa.webapis.generic.IXMLService;
import sk.prasa.webapis.generic.ServiceBase;
import sk.prasa.webapis.generic.DynamicXMLService;

import com.bourre.events.BasicEvent;
import com.bourre.events.NumberEvent;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.bourre.commands.Delegate;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.generic.PicasaServiceBase extends ServiceBase
{
	public static var INIT : EventType 		= new EventType("init");
	public static var PROGRESS : EventType 	= new EventType("progress");
	public static var TIMEOUT : EventType 	= new EventType("timeout");
	public static var ERROR : EventType 	= new EventType("error");
	
	public function PicasaServiceBase(owner : Object)
	{
		super( owner );
	}
	
	public function getXMLService() : IXMLService
	{
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		
		var s : IXMLService = new DynamicXMLService();
			s.addEventListener( DynamicXMLService.onErrorEVENT, 		Delegate.create( this, onError ));
			s.addEventListener( DynamicXMLService.onLoadProgressEVENT,Delegate.create( this, onProgress ));
			s.addEventListener( DynamicXMLService.onLoadInitEVENT, 	Delegate.create( this, onInit ));
			s.addEventListener( DynamicXMLService.onTimeOutEVENT, 	Delegate.create( this, onTimeout ));
	
		var d = s.getDeserializer();
			d.addType("plain",					d, d.getString);
			d.addType("text",					d, d.getString);
			d.addType("text/html",				d, d.getString);
			d.addType("image/jpeg",				d, d.getObjectWithAttributes);
			d.addType("application/atom+xml",	d, d.getObjectWithAttributes);
			d.addType(undefined,				d, d.getObjectWithAttributes);
			
			d.pushInArray = true;
			d.deserializeAttributes = true;
			
		return s;
	}
	
	public function onError(evt : IEvent) : Void
	{
		broadcastEvent(new BasicEvent(ERROR));
	}

	public function onProgress(evt : IEvent) : Void
	{
		var tEvt : LibEvent = LibEvent(evt);
		broadcastEvent(new NumberEvent(PROGRESS,tEvt.getPerCent()));
	}
	
	public function onInit(evt : IEvent) : Void
	{
		broadcastEvent(new BasicEvent(INIT));
	}
	
	public function onTimeout(evt : IEvent) : Void
	{
		broadcastEvent(new BasicEvent(TIMEOUT));
	}
}