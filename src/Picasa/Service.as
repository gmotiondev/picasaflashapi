/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;import com.bourre.data.libs.LibEvent;

import Picasa.ServiceMap;
import Picasa.request.IRequest;
 
class Picasa.Service extends ServiceMap
{	
	private var __d:XMLToObject;
	private var __o:Object;
	private var __request:IRequest;
	
	public var onServiceLoaded:Function;
	
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
	public function send():Void
	{
		__d = new XMLToObject(new Object());
		
		var tD = __d.getDeserializer();
		
			tD.addType("plain",tD,tD.getString);
			tD.addType("text",tD,tD.getString);
			tD.addType("text/html",tD,tD.getString);
			
			tD.addType("image/jpeg",tD,tD.getObjectWithAttributes);
			tD.addType("application/atom+xml",tD,tD.getObjectWithAttributes);
		
		__d.addEventListener(XMLToObject.onLoadInitEVENT,this,onFileLoad);
		__d.addEventListener(XMLToObject.onLoadProgressEVENT,this,onFileProgress);
		__d.addEventListener(XMLToObject.onTimeOutEVENT,this,onFileTimeout);
		__d.addEventListener(XMLToObject.onErrorEVENT,this,onFileError);

		__d.load(__request.getRequest());
		trace("load: "+__request.getRequest());
	}


	// Returns deserialized xml data.
	private function getData():Object
	{
		return __o;
	}
	
	// If file loaded successfuly, get the deserialized xml object and invoke onInitialize
	private function onFileLoad(e:LibEvent):Void 
	{ 
		__o = __d.getObject();
		
		onInitialize();
	}

	// Override when extended.
	public function onInitialize(e:LibEvent):Void {}
	public function onFileProgress(e:LibEvent):Void {}
	public function onFileTimeout(e:LibEvent):Void {}
	public function onFileError(e:LibEvent):Void {}

	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}