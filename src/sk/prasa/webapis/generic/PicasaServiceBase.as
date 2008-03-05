/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.generic.ServiceBase;
import sk.prasa.webapis.generic.DynamicXMLService;

import com.bourre.events.BasicEvent;
import com.bourre.events.NumberEvent;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.bourre.commands.Delegate;

class sk.prasa.webapis.generic.PicasaServiceBase extends ServiceBase
{
	public static var INIT : EventType 		= new EventType("init");
	public static var PROGRESS : EventType 	= new EventType("progress");
	public static var TIMEOUT : EventType 	= new EventType("timeout");
	public static var ERROR : EventType 	= new EventType("error");
	
	public function PicasaServiceBase(owner:Object)
	{
		super(owner);
	}
	
	public function getXMLService() : DynamicXMLService
	{
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		
		var tService:DynamicXMLService = new DynamicXMLService();
			tService.addEventListener(XMLToObject.onErrorEVENT, 		Delegate.create(this,onError));
			tService.addEventListener(XMLToObject.onLoadProgressEVENT, 	Delegate.create(this,onProgress));
			tService.addEventListener(XMLToObject.onLoadInitEVENT, 		Delegate.create(this,onInit));
			tService.addEventListener(XMLToObject.onTimeOutEVENT, 		Delegate.create(this,onTimeout));
	
		var tDeserializer = tService.getDeserializer();
			tDeserializer.addType(undefined,				tDeserializer, tDeserializer.getObjectWithAttributes);
			tDeserializer.addType("plain",					tDeserializer, tDeserializer.getString);
			tDeserializer.addType("text",					tDeserializer, tDeserializer.getString);
			tDeserializer.addType("text/html",				tDeserializer, tDeserializer.getString);
			tDeserializer.addType("image/jpeg",				tDeserializer, tDeserializer.getObjectWithAttributes);
			tDeserializer.addType("application/atom+xml",	tDeserializer, tDeserializer.getObjectWithAttributes);
			
			tDeserializer.pushInArray = true;
			tDeserializer.deserializeAttributes = true;
			
		return tService;
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