package  
{
	import sk.prasa.webapis.picasa.PicasaService;
	
	import flash.display.Sprite;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Application extends Sprite 
	{
		public static var USERID : String = "thisispinkfu";
		public static var ALBUMID : String = "5094406297232552993";

		public function Application()
		{
			trace("Application up and running!");
			
			var tService : PicasaService = PicasaService.getInstance();
				//tService.albums.list(USERID);
				//tService.photos.list(USERID, ALBUMID);
				//tService.comments.user(USERID);
				tService.tags.user(USERID);
		}
	}
}
