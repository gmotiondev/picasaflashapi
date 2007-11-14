/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Author
{
	private var __name:String;
	private var __email:String;
	private var __uri:String;
	
	//
	public function Author(n:String,e:String,u:String)
	{
		__name = n;
		__email = e; 
		__uri = u;
	}
	
	// 
	public function get name():String
	{
		return __name;
	}
	
	// 
	public function set name(v:String):Void
	{
		__name = v;
	}
	
	// 
	public function get email():String
	{
		return __email;
	}
	
	// 
	public function set email(v:String):Void
	{
		__email = v;
	}
	
	// 
	public function get uri():String
	{
		return __uri;
	}
	
	// 
	public function set uri(v:String):Void
	{
		__uri = v;
	}
}