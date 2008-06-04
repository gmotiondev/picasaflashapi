package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Photos extends MethodHelper
	{
		/**
		 * List of users photos in specified album 
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=photo
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param params String Params to alter the feed url
		 */
		public function list(userid : String, albumid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = params.merge(urlparams);
				p.suffix = "user/" + userid + "/albumid/" + albumid;
				
				// overwrite!
				p.kind = "photo";	
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
		 * List of tagged users photos in specified album  
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?tag=sometag
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param tag String Tag
		 * @param params String Params to alter the feed url
		 */
		public function list_by_tag(userid : String, albumid : String, tag : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = params.merge(urlparams);
				p.suffix = "user/" + userid + "/albumid/" + albumid;
				
				// overwrite!
				p.kind = "photo";	
				p.tag = tag;
				p.q = null;
			
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}

		/**
		 * Retrieves single photo entry
		 * NOT YET IMPLEMENTED  
		 * Loads e.g. 
		 * 
		 * @param userid String Picasaweb user id
		 * @param albumid String Picasaweb album id
		 * @param photoid String Picasaweb photo id
		 * @param params String Params to alter the feed url
		 */
		public function single(userid : String, albumid : String, photoid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			throw new Error("Not yet implemented.");
		}
	}
}