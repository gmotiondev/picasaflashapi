/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;import com.bourre.data.libs.LibEvent;
import com.bourre.events.IEvent;

import Picasa.ServiceMap;
import Picasa.IService;
import Picasa.request.IRequest;

 
//class Picasa.Service extends ServiceMap
class Picasa.Service implements IService
{	
	private var __d:XMLToObject;
	//private var __o:Object;
	private var __request:IRequest;
	
	/**
	 * Constructor
	 */	
	public function Service(aRequest:IRequest)
	{
		__request = aRequest;

		XMLToObjectDeserializer.DESERIALIZE_ATTRIBUTES = true;
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		XMLToObjectDeserializer.PUSHINARRAY_IDENTICAL_NODE_NAMES = true;
	}
	
	// link to send();
	public function load():Void
	{
		send();
	}
		
	// send request
	public function send():Boolean
	{
		__d = new XMLToObject(new Object());
		
		var tD = __d.getDeserializer();
		
			tD.addType("plain",tD,tD.getString);
			tD.addType("text",tD,tD.getString);
			tD.addType("text/html",tD,tD.getString);
			tD.addType("image/jpeg",tD,tD.getObjectWithAttributes);
			tD.addType("application/atom+xml",tD,tD.getObjectWithAttributes);
		
		//__d.addEventListener(XMLToObject.onLoadInitEVENT,this,onFileLoad);
		__d.addEventListener(XMLToObject.onLoadInitEVENT,this,		onServiceInit);
		__d.addEventListener(XMLToObject.onLoadProgressEVENT,this,	onServiceProgress);
		__d.addEventListener(XMLToObject.onTimeOutEVENT,this,		onServiceTimeout);
		__d.addEventListener(XMLToObject.onErrorEVENT,this,			onServiceError);

		__d.load(__request.getRequest());
		trace("load: "+__request.getRequest());
		
		return true;
	}


	// Returns deserialized xml data.
	private function getData():Object
	{
		return __d.getObject();
	}
	
	// If file loaded successfuly, get the deserialized xml object and invoke onInitialize
	/*
	private function onFileLoad(e:LibEvent):Void 
	{ 
		//__o = __d.getObject();
		
		onInitialize();
	}
	*/

	// Override when extended.
	public function onServiceLoaded(e:IEvent):Void {};
	public function onServiceInit(e:LibEvent):Void {}
	public function onServiceProgress(e:LibEvent):Void {}
	public function onServiceTimeout(e:LibEvent):Void {}
	public function onServiceError(e:LibEvent):Void {}
	public function notifyChanged(e:IEvent):Void{}
}