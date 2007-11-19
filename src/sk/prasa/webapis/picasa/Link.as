/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Link
{
	//rel:String, type:String, href:String
	private var __href:String;
	private var __type:String;
	private var __rel:String;
	
	// 
	public function Link(h:String, t:String, r:String)
	{
		//trace("Link("+h+", "+t+", "+r+")");
		
		__href = h;
		__type = t;
		__rel = r;
	}
	
	// 
	public function get href():String
	{
		return __href;
	}
	
	// 
	public function set href(v:String):Void
	{
		__href = v;
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
	public function get rel():String
	{
		return __rel;
	}
	
	// 
	public function set rel(v:String):Void
	{
		__rel = v;
	}
	
	public function toString():String
	{
		return "[Link href="+href+", type="+type+", rel="+rel+"]";
	}
}