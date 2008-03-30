/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Content
{
	public var type : String;
	public var src : String;
	 
	public function Content(t : String, s : String)
	{
		type = t;
		src = s;
	}
	
	public function toString() : String
	{
		return "[Content " +
			" type=" + type + 
			", src=" + src + 
			"]";
	}
}