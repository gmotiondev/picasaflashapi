package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.core.receiver.albums.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[Event(name="albumsGetList", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="albumsGetListByTag", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="albumsGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
	public class Albums 
	{
		private var service : PicasaService;
		
		public function Albums(srv : PicasaService)
		{
			service = srv;
		}
		
		/**
		 * List all albums from user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=album
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, params : UrlParams = null) : void
		{
			var s : String = "user/" + userid;
			var p : UrlParams = service.mergeUrlParams(params);
				p.kind = "album";	// override!
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new AlbumsListReceiver(service);
			var tCommand : ICommand = new GetFeedCommand(tReceiver, service, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
		
		/**
		 * List photos from all albums by tag
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=photo&tag=sometag
		 * 
		 * @param userid String Picasaweb user id
		 * @param tag String Tag
		 * @param params UrlParams Parameters to alter the feed url
		 */
		public function list_by_tag(userid : String, tag : String, params : UrlParams = null) : void
		{
			var s : String = "user/" + userid;
			var p : UrlParams = service.mergeUrlParams(params);
				p.kind = "photo";	// override!
				p.tag = tag;
				p.q = null;
	
			var tReceiver : IReceiver = new AlbumsListByTagReceiver(service);
			var tCommand : ICommand = new GetFeedCommand(tReceiver, service, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
		
		/**
		 * Search in albums by query
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=photo&q=somequery
		 * 
		 * @param userid String Picasaweb user id
		 * @param query String Search query
		 * @param params UrlParams Parameters to alter the feed url
		 */
		public function search(userid : String, query : String, params : UrlParams = null) : void
		{
			var s : String = "user/" + userid;
			var p : UrlParams = service.mergeUrlParams(params);
				p.kind = "photo";	// override!
				p.tag = null;
				p.q = query;
	
			var tReceiver : IReceiver = new AlbumsSearchReceiver(service);
			var tCommand : ICommand = new GetFeedCommand(tReceiver, service, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
	}
}
