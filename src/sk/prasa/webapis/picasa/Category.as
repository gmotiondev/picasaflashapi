/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Category
{
	private var __term:String;
	private var __scheme:String;
	
	// 
	public function Category(t:String, s:String)
	{
		__term = t;
		__scheme = s;
	}
	
	// 
	public function get term():String
	{
		return __term;
	}
	
	// 
	public function set term(v:String):Void
	{
		__term = v;
	}
	
	// 
	public function get scheme():String
	{
		return __scheme;
	}
	
	// 
	public function set scheme(v:String):Void
	{
		__scheme = v;
	}
}