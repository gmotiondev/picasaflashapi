package sk.prasa.webapis.picasa.core 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[Event(name="albumsGetList", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="albumsGetListByTag", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="albumsGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
	public class Albums 
	{
		public function Albums()
		{
		}
		
		/**
		 * List all albums from user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=album
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, params : UrlParams) : void
		{

		}
	}
}
