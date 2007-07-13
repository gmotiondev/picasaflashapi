import Picasa.tools.IJSONParser;
import Picasa.tools.JSONLib;
import Picasa.tools.JSON;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */

class Picasa.tools.JSONParser implements IJSONParser
{
	private var __owner:JSONLib;
	
	public function JSONParser()
	{
	}
	
	public function setOwner(aOwner:JSONLib):Void
	{
		__owner = aOwner;
	}
	
	public function parse(sData:String):Void
	{
		var json:JSON = new JSON();
		
		try
		{
			__owner.setData(json.parse(sData));
		} catch(e)
		{
			trace(e.name + ":" + e.message + ":" + e.at + ":" + e.text);
		}
	}
	
	public function stringify(aObj:Object):Void
	{
		var json:JSON = new JSON();
		
		try {
			__owner.setData(json.stringify(aObj));
		} catch(e)
		{
	        trace(e.name + ":" + e.message + ":" + e.at + ":" + e.text);
	    }
	}
}
