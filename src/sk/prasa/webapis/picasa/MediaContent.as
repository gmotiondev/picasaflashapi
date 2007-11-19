/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.MediaContent
{
	private var __url:String;
	private var __type:String;
	private var __medium:String;
	private var __height:Number;
	private var __width:Number;
	private var __fileSize:Number;
	
	public function MediaContent(u:String,t:String,m:String,h:Number,w:Number,s:Number)
	{
		__url = u;
		__type = t;
		__medium = m;
		__height = h;
		__width = w;
		__fileSize = s;
	}
	
	public function get url():String
	{
		return __url;
	}
	
	public function set url(v:String):Void
	{
		__url = v;
	}
	
	public function get type():String
	{
		return __type;
	}
	
	public function set type(v:String):Void
	{
		__type = v;
	}
	
	public function get medium():String
	{
		return __medium;
	}
	
	public function set medium(v:String):Void
	{
		__type = v;
	}
	
	public function get height():Number
	{
		return __height;
	}
	
	public function set height(v:Number):Void
	{
		__height = v;
	}
	
	public function get width():Number
	{
		return __width;
	}
	
	public function set width(v:Number):Void
	{
		__width = v;
	}
	
	public function get fileSize():Number
	{
		return __fileSize;
	}
	
	public function set fileSize(v:Number):Void
	{
		__fileSize = v;
	}
	
	public function toString():String
	{
		return "[MediaContent url="+url+", type="+type+", medium="+medium+", height="+height+", width="+width+", fileSize="+fileSize+"]";	
	}
}