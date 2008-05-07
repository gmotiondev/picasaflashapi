package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.*;
	import sk.prasa.webapis.picasa.core.command.*;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.core.receiver.community.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[Event(name="communityGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")] 
	
	public class Community 
	{
		private var service : PicasaService;
		
		public function Community(srv : PicasaService)
		{
			service = srv;
		}

		/**
		 * List photos in community by given query 
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm
		 * 
		 * @param query String Query
		 * @param params String Params to alter the feed url
		 */
		public function search(query : String, params : UrlParams = null) : void
		{
			var s : String = "all";
			var p : UrlParams = service.mergeUrlParams(params);
				p.kind = "photo";	// override!
				p.tag = null;
				p.q = query;
	
			var tReceiver : IReceiver = new CommunitySearchReceiver(service);
			var tCommand : ICommand = new GetFeedCommand(tReceiver, service, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		} 
	}
}
