import com.bourre.data.libs.LibEvent;
//import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;
import Picasa.tools.JSONLib;
import Picasa.tools.JSONParser;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */
 
class Picasa.JSONService
{	
	private var __d:Picasa.tools.JSONLib;
	private var __o;
	
	private var __feed:String;
	private var __kind:String;
	
	private var __map : Map2;
	private var __current : String;
	private var __it : ObjectIterator2;
	public var onServiceLoaded : Function;
	
	/**
	 * Constructor
	 */	
	public function JSONService(aUrl:String,aKind:String)
	{
		setFeedURL(aUrl,aKind);
		initialize();
	}
	/**
	 * Load xml from aUrl
	 */
	public function load():Void
	{
		setRequest(getFeedURL());
	}
	/**
	 * Service initialize
	 */
	private function initialize():Void
	{
	}
	public function setFeedURL(aUrl:String,aKind:String):Void
	{
		__feed = aUrl;
		__kind = aKind;
	}
	public function getFeedURL():String
	{
		//return __feed+"?kind="+__kind;
		return __feed;
	}
	/**
	 * Sets feed's url and starts loading xml feed
	 * @param aFeedURL Complete url string.
	 */
	private function setRequest(aFeed:String):Void
	{
		__d = new JSONLib(new JSONParser());
	
		__d.addEventListener(JSONLib.onLoadInitEVENT,this,onFileLoad);
		__d.addEventListener(JSONLib.onLoadProgressEVENT,this,onFileProgress);
		__d.addEventListener(JSONLib.onTimeOutEVENT,this,onFileTimeout);
		__d.addEventListener(JSONLib.onErrorEVENT,this,onFileError);

		__d.load(aFeed);
		//__d.load("http://pipes.yahooapis.com/pipes/pipe.run?_id=JKGxc7Iv3BGDYJCjqGIyXQ&_render=json&_run=1&feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu");
	}

	/**
	 * Returns deserialized xml data.
	 * @return deserialized xml data
	 */
	private function getData()
	{
		return __o;
	}
	/**
	 * If file loaded successfuly, get the deserialized xml object and invoke onInitialize
	 * @param e LibEvent event.
	 */
	private function onFileLoad(e:LibEvent) : Void 
	{ 
		__o = __d.getData();
		//trace("data: "+__o.value.items[0].icon);
		onInitialize();
	}
	/**
	 * Override when extended.
	 */
	public function onInitialize(e:LibEvent):Void {}
	public function onFileProgress(e:LibEvent):Void {}
	public function onFileTimeout(e:LibEvent):Void {}
	public function onFileError(e:LibEvent):Void {}
	/**
	 * Clear and reset map.
	 */
	private function clear():Void
	{
		__map.clear();
		__current = null;
		
		reset();
	}
	/**
	 * Reset map.
	 */
	private function reset():Void
	{
		
		if(size() > 0)
		{
			__it = __map.getKeysIterator();
		}
		else
		{
			__it = null ;
		}
	}
	/**
	 * Get size of the map. Album photos count.
	 * @return album photos count.
	 */
	private function size():Number
	{
		return __map.getSize();
	}
	private function contains(aID:String):Boolean
	{
		return __map.containsKey(aID);
	}
	private function get current():String
	{
		return __current;
	}
	private function set current(a:String):Void
	{
		__current = a;
	}
	private function get map():Map2
	{
		return __map;
	}
	private function set map(aMap:Map2):Void
	{
		__map = aMap;
	}
	private function get iterator():ObjectIterator2
	{
		return __it;
	}
	private function set iterator(aIterator:ObjectIterator2):Void
	{
		__it = aIterator;
	}
	/**
	 * 
	 */
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}