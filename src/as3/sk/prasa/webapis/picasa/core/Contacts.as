package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.core.command.GetFeedCommand;
	import sk.prasa.webapis.picasa.core.command.ICommand;
	import sk.prasa.webapis.picasa.core.command.Invoker;
	import sk.prasa.webapis.picasa.core.receiver.GetContactsFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;
			
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Contacts extends MethodHelper
	{
		/**
		 * List contacts from user, this is (contacts)user-based feed
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/contacts?kind=user
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = params.merge(urlparams);
				p.suffix = "user/" + userid + "/contacts";
				
				// override!
				p.kind = "user";
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new GetContactsFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}
	}
}