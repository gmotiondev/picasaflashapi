/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Category
{
	public var term:String;
	public var scheme:String;
	
	// 
	public function Category(t : String, s : String)
	{
		term = t;
		scheme = s;
	}
	
	public function toString() : String
	{
		return "[Category term=" + term + ", scheme=" + scheme + "]";
	}
}