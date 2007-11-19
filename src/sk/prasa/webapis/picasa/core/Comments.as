/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import com.bourre.data.libs.XMLToObjectEvent;

[Event(name="commentsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Comments
{
	private var __service;
	
	public function Comments(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=comment
	public function user(userid:String):Void
	{
	}
	
	// 
	private function user_complete(event:XMLToObjectEvent):Void
	{
	}
	
	// 
	public function photo(userid:String, albumid:String, photoid:String):Void
	{	
	}
	
	// 
	private function photo_complete(event:XMLToObjectEvent):Void
	{
	}
}