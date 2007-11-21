/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import com.bourre.data.libs.XMLToObjectEvent;

[Event(name="tagsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

// http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/lomo

class sk.prasa.webapis.picasa.core.Tags
{
	private var __service:PicasaService;
	
	public function Tags(service:PicasaService)
	{
		__service = service;
	}
	
	// list tags for specified user
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=tag
	public function user(userid:String):Void
	{
	}
	
	private function user_complete(event:XMLToObjectEvent):Void
	{
	}
	
	// list tags for specified album
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?kind=tag
	public function album(userid:String,albumid:String):Void
	{
	}

	private function album_complete(event:XMLToObjectEvent):Void
	{
	}

	// list tags for specified photo
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897/photoid/5110368147163787298?kind=tag
	public function photo(userid:String,albumid:String,photoid:String):Void
	{
	}
	
	private function photo_complete(event:XMLToObjectEvent):Void
	{
	}
	
}