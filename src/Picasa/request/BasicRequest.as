/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.request.BasicRequest
{
	private var __feed:String;
	private var __kind:String;
	private var __params:Object;
	
	public function BasicRequest(aFeed:String, aKind:String, aGetParams:Object)
	{
		__feed = aFeed;
		__kind = aKind;
		__params = aGetParams;
	}
	
	public function getFeed():String
	{
		return __feed;
	}
	
	public function getKind():String
	{
		return __kind;
	}
	
	public function getParams():String
	{
		var tParams:String = "";
		
		for(var tKey:String in __params)
		{
			tParams += "&" + tKey + "=" + __params[tKey];
		}	
		
		return tParams;
	}
	/**
	 * OVERRIDE THIS!	 */
	public function getRequest():String
	{
		return null;
	}
}