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
	public class Community extends MethodHelper
	{
		/**
		 * List photos in community by given query, this is query-based feed
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm
		 * 
		 * @param query String Query
		 * @param params String Params to alter the feed url
		 */
		public function search(query : String, urlparams : UrlParams = null) : PicasaResponder
		{
			var p : UrlParams = params.merge(urlparams);
				p.suffix = "all";
				
				// override!
				p.kind = "photo";
				p.tag = null;
				p.q = query;
	
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		} 
	}
}