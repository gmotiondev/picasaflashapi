package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.GetAlbumFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.GetPhotoFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.GetUserFeedReceiver;
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
		 * Get list of all comments for specified user, this is user-based feed
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
	
			//var tReceiver : IReceiver = new GetFeedReceiver();
			var tReceiver : IReceiver = new GetUserFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
				
			return tReceiver.responder;
		}

		/**
		 * List album comments for specified user, this is album-based feed
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
	
			//var tReceiver : IReceiver = new GetFeedReceiver();
			var tReceiver : IReceiver = new GetAlbumFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}

		/**
		 * List photo comments for specified user and album, this is photo-based feed
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
		
			//var tReceiver : IReceiver = new GetFeedReceiver();
			var tReceiver : IReceiver = new GetPhotoFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}
	}
}