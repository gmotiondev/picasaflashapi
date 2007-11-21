/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import com.bourre.data.libs.XMLToObjectEvent;

[Event(name="commentsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Comments
{
	private var __service;
	
	public function Comments(service:PicasaService)
	{
		__service = service;
	}
	
	// list all comments for specified user
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=comment
	public function user(userid:String):Void
	{
	}
	
	// 
	private function user_complete(event:XMLToObjectEvent):Void
	{
	}
	
	// list comments for specified album
	// http://www.prasa.sk/proxy.php?gws_path=http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?kind=comment
	public function album(userid:String, albumid:String,url_params:UrlParams):Void
	{
	
	}
	
	private function album_complete(event:XMLToObjectEvent):Void
	{
	
	}
	
	// list comments for specified photo
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/album/SampleAlbum/photoid/5094407740341564914?kind=comment
	public function photo(userid:String, albumid:String, photoid:String):Void
	{	
	}
	
	// 
	private function photo_complete(event:XMLToObjectEvent):Void
	{
	}
}