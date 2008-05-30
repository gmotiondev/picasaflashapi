package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Albums extends MethodHelper
	{		
		/**
		 * List all albums from user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=album
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var s : String = "user/" + userid;
			var p : UrlParams = params.merge(urlparams);
				p.kind = "album";	
				// override!
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}

		/**
		 * List photos from all albums by tag
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=photo&tag=sometag
		 * 
		 * @param userid String Picasaweb user id
		 * @param tag String Tag
		 * @param params UrlParams Parameters to alter the feed url
		 */
		public function list_by_tag(userid : String, tag : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var s : String = "user/" + userid;
			var p : UrlParams = params.merge(urlparams);
				p.kind = "photo";	
				// override!
				p.tag = tag;
				p.q = null;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}

		/**
		 * Search in albums by query
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=photo&q=somequery
		 * 
		 * @param userid String Picasaweb user id
		 * @param query String Search query
		 * @param params UrlParams Parameters to alter the feed url
		 */
		public function search(userid : String, query : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var s : String = "user/" + userid;
			var p : UrlParams = params.merge(urlparams);
				p.kind = "photo";	
				// override!
				p.tag = null;
				p.q = query;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}
	}
}