/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Content
{
	private var __type:String;
	private var __src:String;
	
	// 
	public function Content(t:String, s:String)
	{
		__type = t;
		__src = s;
	}
	
	// 
	public function get type():String
	{
		return __type;
	}
	
	// 
	public function set type(v:String):Void
	{
		__type = v;
	}
	
	// 
	public function get src():String
	{
		return __src;
	}
	
	// 
	public function set src(v:String):Void
	{
		__src = v;
	}
}