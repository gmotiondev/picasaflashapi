/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Link
{
	public var href : String;
	public var type : String;
	public var rel : String;
	 
	public function Link(h : String, t : String, r : String)
	{
		href = h;
		type = t;
		rel = r;
	}
	 	
	public function toString() : String
	{
		return "[Link " +
			" href=" + href + 
			", type=" + type + 
			", rel=" + rel + 
			"]";
	}
}