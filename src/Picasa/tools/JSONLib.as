/**
 * Deprecated, will be deleted
 */
 import com.bourre.commands.Delegate;
import com.bourre.data.libs.AbstractLib;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;

import Picasa.tools.IJSONParser;
import Picasa.tools.JSONLibEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */

class Picasa.tools.JSONLib extends AbstractLib
{
	public static var onLoadInitEVENT:EventType = AbstractLib.onLoadInitEVENT;
	public static var onLoadProgressEVENT:EventType = AbstractLib.onLoadProgressEVENT;
	public static var onTimeOutEVENT:EventType = AbstractLib.onTimeOutEVENT;
	
	private var _data : String;
	private var _oParser : IJSONParser;

	public function JSONLib(parser:IJSONParser)
	{
		setContent(new LoadVars());
		_oParser = parser;
	}

	public function getParser():IJSONParser
	{
		return _oParser;
	}
	
	public function setParser(parser:IJSONParser):Void
	{
		_oParser = parser;
	}
	
	public function parseData(sData:String):Void
	{
		getParser().setOwner(this);
		getParser().parse(sData);
		
    	super.onLoadInit();
	}
	
	public function initEventSource():Void
	{
		_e = new JSONLibEvent(null, this);
	}
	
	public function load (url : String):Void
	{
		if (url != undefined) setURL(url);
		_data = null;
		
  		getContent().onData = Delegate.create(this, _onData);
  		getContent().load(this.getURL());
  		super.load();
	}
	
	public function onLoadInit():Void
	{
		// overwriting for delaying 'onLoadInit' broadcast
	}
	
	private function _onData(src:String):Void
	{
		if( src != null )
        {
        	getContent().loaded = true;
        	getContent().onLoad(true);
        	
        	if (getParser() == undefined)
        	{
        		_data = src;
        		fireEventType(JSONLib.onLoadInitEVENT);
        		
        	} else
        	{
        		parseData(src);
        	}
        }
   		 else
        {
        	getContent().onLoad(false);
        	fireEventType(JSONLib.onErrorEVENT);
        }
	}
	
	public function getData()
	{
		return _data;
	}
	
	public function setData(data)
	{
		_data = data;
	}
	
	public function getContent():LoadVars
	{
		return LoadVars(super.getContent());
	}

	public function setContent(aLv:LoadVars):Void
	{
		super.setContent(aLv);
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}