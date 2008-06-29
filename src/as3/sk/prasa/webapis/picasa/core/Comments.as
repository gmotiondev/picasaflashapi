package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * Comments methods
	 */
	public class Comments extends MethodHelper
	{
		/**
		 * Get list of all comments for specified user. This is user-based feed
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=comment
		 * 
		 * The "result data" contains <code>meta</code> as <code>UserMeta</code> and <code>entries</code> as <code>Array.<CommentEntry></code>
		 * 
		 * @param userid String Picasaweb user id
		 * @param urlparams UrlParams Parameters to alter the feed url
		 */
		public function user(userid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = this.params.merge(urlparams);
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
		 * List album comments for specified user. This is album-based feed.
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=comment
		 * 
		 * The "result data" contains <code>meta</code> as <code>AlbumMeta</code> and <code>entries</code> as <code>Array.<CommentEntry></code>
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param urlparams UrlParams Parameters to alter the feed url
		 */
		public function album(userid : String, albumid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = this.params.merge(urlparams);
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
		 * List comments for given photo. This is photo-based feed
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=comment
		 * 
		 * The "result data" contains <code>meta</code> as <code>PhotoMeta</code> and <code>entries</code> as <code>Array.<CommentEntry></code>
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param photoid String Picasaweb photo id
		 * @param urlparams UrlParams Parameters to alter the feed url
		 */
		public function photo(userid : String, albumid : String, photoid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = this.params.merge(urlparams);
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