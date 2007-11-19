/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.log.PixlibStringifier;
import Picasa.request.RequestType;

class Picasa.request.BasicRequest
{
	private var __feed:String;
	private var __type:RequestType;
	private var __params:Object;
	
	public function BasicRequest(aFeed:String, aType:RequestType, aGetParams:Object)
	{
		__feed = aFeed;
		__type = aType;
		__params = aGetParams;
	}
	
	// 
	public function getFeed():String
	{
		return __feed;
	}
	
	// 
	public function getRequestType():RequestType
	{
		return __type;
	}
	
	// 
	public function getParams():String
	{
		var tParams:String = "";
		
		for(var tKey:String in __params) {
			tParams += "&" + tKey + "=" + __params[tKey];
		}
		
		return tParams;
	}
}