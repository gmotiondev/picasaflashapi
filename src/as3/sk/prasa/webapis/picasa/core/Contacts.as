package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.core.command.GetFeedCommand;
	import sk.prasa.webapis.picasa.core.command.ICommand;
	import sk.prasa.webapis.picasa.core.command.Invoker;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Contacts extends MethodHelper
	{
		/**
		 * List contacts from user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=contacts
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = params.merge(urlparams);
				p.suffix = "user/" + userid;
				
				// override!
				p.kind = "contacts";
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