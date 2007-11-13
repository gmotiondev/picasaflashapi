/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;

class sk.prasa.webapis.picasa.core.Albums
{
	private var __service:PicasaService;
	
	public function Albums(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID?kind=album
	public function list(userid:String):Void
	{
	
	}
}

