import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 *  
 */

class Picasa.Service
{
	private static var __instance:Service;
	private var __data:XMLToObject;
	private var __xml:XML;

	/**
	 * 
	 */	
	public function Service(aParent:Object)
	{
		initialize();
	}
	/**
	 * Load xml from aUrl
	 */
	public function load(aUrl:String):Void
	{
		setFeed(aUrl);
	}
	
	private function initialize():Void
	{
		XMLToObjectDeserializer.DESERIALIZE_ATTRIBUTES = true;
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		XMLToObjectDeserializer.PUSHINARRAY_IDENTICAL_NODE_NAMES = true;
	}
	private function setFeed(aFeedURL:String):Void
	{
		__data = new XMLToObject(new Object());
		
		var tD = __data.getDeserializer();
			tD.addType("plain",tD,tD.getString);
			tD.addType("text",tD,tD.getString);
			tD.addType("image/jpeg",tD,tD.getObjectWithAttributes);
			tD.addType("application/atom+xml",tD,tD.getObjectWithAttributes);
		
		__data.addEventListener(XMLToObject.onLoadInitEVENT,this,onFileLoad);
		__data.addEventListener(XMLToObject.onLoadProgressEVENT,this,onFileProgress);
		__data.addEventListener(XMLToObject.onTimeOutEVENT,this,onFileTimeout);
		__data.addEventListener(XMLToObject.onErrorEVENT,this,onFileError);
		
		__data.load(aFeedURL);
	}
	/**
	 * 
	 */
	private function getData():XML
	{
		return __xml;
	}	
	/**
	 *  Override when extended
	 */
	private function onInitialize(e:IEvent):Void
	{
	}
	/**
	 * 
	 */
	private function onFileLoad(e:IEvent) : Void 
	{ 
		__xml = __data.getObject();
		onInitialize();
	}
	/**
	 * Override when extended.
	 */
	private function onFileProgress(e:IEvent):Void
	{
	}
	/**
	 * Override when extended.
	 */
	private function onFileTimeout(e:IEvent):Void
	{
	}
	/**
	 * Override when extended.
	 */
	private function onFileError(e:IEvent):Void
	{
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}