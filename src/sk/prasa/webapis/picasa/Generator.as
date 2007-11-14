/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Generator
{
	// <generator version='1.00' uri='http://picasaweb.google.com/'>Picasaweb</generator>
	
	private var __name:String;
	private var __version:String;
	private var __uri:String;
	
	public function Generator(n:String,v:String,u:String)
	{
		//trace("Generator("+n+", "+v+", "+u+")");
		
		__name = n;
		__version = v;
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
	public function get version():String
	{
		return __version;
	}
	
	// 
	public function set version(v:String):Void
	{
		__version = v;
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