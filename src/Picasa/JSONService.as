/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.LibEvent;

import Picasa.tools.JSONLib;
import Picasa.tools.JSONParser;
import Picasa.ServiceMap;
import Picasa.request.BasicRequest;

class Picasa.JSONService extends ServiceMap
{	
	private var __d:Picasa.tools.JSONLib;
	private var __o:Object;
	private var __request:BasicRequest;
	
	public var onServiceLoaded : Function;

	// constructor	
	public function JSONService(aRequest:BasicRequest)
	{
		__request = aRequest;
	}
	
	// link to send
	public function load():Void
	{
		send();
	}
	
	// send request
	public function send():Void
	{
		__d = new JSONLib(new JSONParser());
	
		__d.addEventListener(JSONLib.onLoadInitEVENT,this,onFileLoad);
		__d.addEventListener(JSONLib.onLoadProgressEVENT,this,onFileProgress);
		__d.addEventListener(JSONLib.onTimeOutEVENT,this,onFileTimeout);
		__d.addEventListener(JSONLib.onErrorEVENT,this,onFileError);

		__d.load(__request.getRequest());
	}

	// Returns deserialized xml data.
	private function getData()
	{
		return __o;
	}
	
	// If file loaded successfuly, get the deserialized xml object and invoke onInitialize
	private function onFileLoad(e:LibEvent) : Void 
	{ 
		__o = __d.getData();
		//trace("data: "+__o.value.items[0].icon);
		onInitialize();
	}
	
	// Override when extended.
	public function onInitialize(e:LibEvent):Void {}
	public function onFileProgress(e:LibEvent):Void {}
	public function onFileTimeout(e:LibEvent):Void {}
	public function onFileError(e:LibEvent):Void {}
}