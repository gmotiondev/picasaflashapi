﻿import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;import com.bourre.data.libs.LibEvent;
//import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */
 
class Picasa.Service
{	
	private var __d:XMLToObject;
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
	public function Service(aUrl:String,aKind:String)
	{
		setFeedURL(aUrl,aKind);
		initialize();
	}
	/**
	 * Load xml from aUrl
	 */
	public function load():Void
	{
		trace("load: "+getFeedURL());
		setRequest(getFeedURL());
	}
	/**
	 * Service initialize	 */
	private function initialize():Void
	{
		XMLToObjectDeserializer.DESERIALIZE_ATTRIBUTES = true;
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		XMLToObjectDeserializer.PUSHINARRAY_IDENTICAL_NODE_NAMES = true;
	}
	public function setFeedURL(aUrl:String,aKind:String):Void
	{
		__feed = aUrl;
		__kind = aKind;
	}
	public function getFeedURL():String
	{
		return __feed+"?kind="+__kind;
	}
	/**
	 * Sets feed's url and starts loading xml feed
	 * @param aFeedURL Complete url string.	 */
	private function setRequest(aFeedURL:String):Void
	{
		__d = new XMLToObject(new Object());
		
		var tD = __d.getDeserializer();
			tD.addType("plain",tD,tD.getString);
			tD.addType("text",tD,tD.getString);
			tD.addType("image/jpeg",tD,tD.getObjectWithAttributes);
			tD.addType("application/atom+xml",tD,tD.getObjectWithAttributes);
		
		__d.addEventListener(XMLToObject.onLoadInitEVENT,this,onFileLoad);
		__d.addEventListener(XMLToObject.onLoadProgressEVENT,this,onFileProgress);
		__d.addEventListener(XMLToObject.onTimeOutEVENT,this,onFileTimeout);
		__d.addEventListener(XMLToObject.onErrorEVENT,this,onFileError);

		__d.load(aFeedURL);
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
		__o = __d.getObject();
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
	public function get current():String
	{
		return __current;
	}
	public function set current(a:String):Void
	{
		__current = a;
	}
	public function get map():Map2
	{
		return __map;
	}
	public function set map(aMap:Map2):Void
	{
		__map = aMap;
	}
	public function get iterator():ObjectIterator2
	{
		return __it;
	}
	public function set iterator(aIterator:ObjectIterator2):Void
	{
		__it = aIterator;
	}
	/**
	 * 	 */
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}