/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.MediaThumbnail
{
	private var __url:String;
	private var __width:Number;
	private var __height:Number;
	
	public function MediaThumbnail(u:String, w:Number, h:Number)
	{
		__url = u;
		__width = w;
		__height = h;
	}
	
	public function get url():String
	{
		return __url;
	}
	
	public function set url(v:String):Void
	{
		__url = v;
	}
	
	public function get width():Number
	{
		return __width;
	}
	
	public function set width(v:Number):Void
	{
		__width = v;
	}
	
	public function get height():Number
	{
		return __height;
	}
	
	public function set height(v:Number):Void
	{
		__height = v;
	}
	
	public function toString():String
	{
		return "[MediaThumbnail url="+url+", width="+width+", height="+height+"]";
	}
}