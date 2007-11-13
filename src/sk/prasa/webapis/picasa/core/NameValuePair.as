/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.core.NameValuePair
{
	private var __name:String;
	private var __value:String;
	
	public function NameValuePair(name:String, value:String)
	{
		__name = name;
		__value = value;
	}
	
	public function get name():String
	{
		return __name;
	}

	public function set name(value:String):Void
	{
		__name = value;
	}

	public function get value():String
	{
		return __value;
	}
	
	public function set value(v:String):Void
	{
		__value = v;
	}
}