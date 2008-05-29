/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Generator
{
	// <generator version='1.00' uri='http://picasaweb.google.com/'>Picasaweb</generator>
	
	public var name : String;
	public var version : String;
	public var uri : String;
	
	public function Generator(n : String, v : String, u : String)
	{
		name = n;
		version = v;
		uri = u;
	}
	
	public function toString() : String
	{
		return "[Generator " +
			" name=" + name + 
			", version=" + version + 
			", uri=" + uri + 
			"]";
	}
}