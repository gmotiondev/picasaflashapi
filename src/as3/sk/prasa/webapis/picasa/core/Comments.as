package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.core.receiver.comments.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * TODO: add url params? do we need them?
	 */
	
	[Event(name="commentsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="commentsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="commentsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
	public class Comments 
	{
		/* Get list of all comments for specified user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 */
		public function user(userid : String) : void
		{
			var s : String = "user/" + userid;
			var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
				p.kind = "comment";	// override!
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new CommentsUserReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
	
		/**
		 * List album comments for specified user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 */
		public function album(userid : String, albumid : String) : void
		{
			var s : String = "user/" + userid + "/albumid/" + albumid;
			var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
				p.kind = "comment";	// override!
				p.tag = null;
				p.q = null;
	
			//__core.execute(__service, Delegate.create(this, album_complete), s, p);
			var tReceiver : IReceiver = new CommentsAlbumReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
		
		/**
		 * List photo comments for specified user and album 
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photoID?kind=comment
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param photoid String Picasaweb photo id
		 */
		public function photo(userid : String, albumid : String, photoid : String) : void
		{
			var s : String = "user/" + userid + "/albumid/" + albumid + "/photoid/" + photoid;
			var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
				p.kind = "comment";	// override!
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new CommentsPhotoReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
	}
}
