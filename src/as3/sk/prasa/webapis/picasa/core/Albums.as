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
//		public function list(userid : String, params : UrlParams) : Void
//		{
//			var s : String = "user/" + userid;
//			var p : UrlParams = __service.mergeUrlParams(params);
//				p.kind = "album";	// overwrite!
//				p.tag = null;
//				p.q = null;
//	
//			__core.invokeMethod(__service, Delegate.create(this, list_complete), false, s, p);
//		}
		
//		private function list_complete(evt : XMLToObjectEvent) : Void
//		{
//			var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST);
//	
//			__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseAlbumList);	
//		}
	}
}
