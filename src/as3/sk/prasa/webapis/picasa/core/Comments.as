package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.objects.UrlParams;
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * TODO: add url params? do we need them?
	 */

	public class Comments extends MethodHelper
	{
		/**
		 * Get list of all comments for specified user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 */
		public function user(userid : String) : PicasaResponder
		{
			var p : UrlParams = params.merge(null);
				p.suffix = "user/" + userid;
				// override!
				p.kind = "comment";	
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
				
			return tReceiver.responder;
		}

		/**
		 * List album comments for specified user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 */
		public function album(userid : String, albumid : String) : PicasaResponder
		{
			var p : UrlParams = params.merge(null);
				p.suffix = "user/" + userid + "/albumid/" + albumid;
				// override!
				p.kind = "comment";	
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}

		/**
		 * List photo comments for specified user and album 
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param photoid String Picasaweb photo id
		 */
		public function photo(userid : String, albumid : String, photoid : String) : PicasaResponder
		{
			var p : UrlParams = params.merge(null);
				p.suffix = "user/" + userid + "/albumid/" + albumid + "/photoid/" + photoid;
				// override!
				p.kind = "comment";	
				p.tag = null;
				p.q = null;
		
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}
	}
}
