package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.core.MethodHelper;
	import sk.prasa.webapis.picasa.core.command.GetFeedCommand;
	import sk.prasa.webapis.picasa.core.command.ICommand;
	import sk.prasa.webapis.picasa.core.command.Invoker;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Custom extends MethodHelper 
	{
		/**
		 * Sends a custom url request, e.g. for prev/next linking 
		 * 
		 * @param url String feed url
		 */ 
		public function query(url : String) : PicasaResponder
		{
			if(url.indexOf(PicasaService.FEED_API_URL) == -1 && url.indexOf(PicasaService.FEED_BASE_URL) == -1)
			{
				throw new Error("This is not Picasaweb service query.");
			}
			
			var tURL : String = "";
			
			tURL = (url.indexOf(PicasaService.FEED_API_URL) > -1) ? 
					url.slice(PicasaService.FEED_API_URL.length) :
					url.slice(PicasaService.FEED_BASE_URL.length);
					
				trace(">>>: " + tURL);
			
			var p : UrlParams = params.merge(null);
				p.suffix = tURL;
		
			var tReceiver : IReceiver = new GetFeedReceiver();
			var tCommand : ICommand = new GetFeedCommand(tReceiver, p);
			var tInvoker : Invoker = new Invoker();
			
				tInvoker.setCommand(tCommand);
				tInvoker.executeCommand();
			
			return tReceiver.responder;
		}
	}
}
