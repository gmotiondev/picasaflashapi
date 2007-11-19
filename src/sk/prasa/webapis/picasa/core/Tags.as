/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import com.bourre.data.libs.XMLToObjectEvent;

[Event(name="tagsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Tags
{
	private var __service:PicasaService;
	
	public function Tags(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID?kind=tag
	public function user(userid:String):Void
	{
	}
	
	private function user_complete(event:XMLToObjectEvent):Void
	{
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=tag
	public function album(userid:String,albumid:String):Void
	{
	}

	private function album_complete(event:XMLToObjectEvent):Void
	{
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=tag
	public function photo(userid:String,albumid:String,photoid:String):Void
	{
	}
	
	private function photo_complete(event:XMLToObjectEvent):Void
	{
	}
	
}