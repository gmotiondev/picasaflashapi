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
	 */
	public class Tags extends MethodHelper
	{
		/**
		 * List all tags for specified user. This is a user-based feed.
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=tag
		 * 
		 * The "result data" contains <code>meta</code> as <code>UserMeta</code> and <code>entries</code> as <code>Array.<TagEntry></code> 
		 * 
		 * @param userid String Picasaweb user id
		 * @param urlparams UrlParams Parameters to alter the feed url
		 */
		public function user(userid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = this.params.merge(urlparams);
				p.suffix = "user/" + userid;
				
				// override!
				p.kind = "tag";	
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
		 * TODO: ... seems not working correctly!
		 * List tags for specified album. This is album-based feed.
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=tag 
		 * 
		 * The "result data" contains <code>meta</code> as <code>AlbumMeta</code> and <code>entries</code> as <code>Array.<TagEntry></code>
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
				p.kind = "tag";	
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
		 * List tags for specified photo. This is photo-based feed.
		 *  - with this, the gphoto.weight isn't set!, logical :)  
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photiID?kind=tag 
		 * 
		 * The "result data" contains <code>meta</code> as <code>PhotoMeta</code> and <code>entries</code> as <code>Array.<TagEntry></code>
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
				p.kind = "tag";	
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