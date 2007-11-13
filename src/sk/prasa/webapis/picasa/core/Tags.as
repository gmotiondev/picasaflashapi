/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;

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
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=tag
	public function album(userid:String,albumid:String):Void
	{
	}

	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=tag
	public function photo(userid:String,albumid:String,photoid:String):Void
	{
	}
}