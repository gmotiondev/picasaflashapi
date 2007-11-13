/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;

class sk.prasa.webapis.picasa.core.Comments
{
	private var __service;
	
	public function Comments(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=comment
	public function list(userid:String, albumid:String, photoid:String):Void
	{
	
	}
}