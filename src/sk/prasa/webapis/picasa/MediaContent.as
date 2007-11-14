/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.MediaContent
{
	public var url:String;
	public var type:String;
	public var medium:String
	public var height:Number;
	public var width:Number;
	public var fileSize:Number;
	
	public function MediaContent(u:String,t:String,m:String,h:Number,w:Number,s:Number)
	{
		url = u;
		type = t;
		medium = m;
		height = h;
		width = w;
		fileSize = s;
	}
}