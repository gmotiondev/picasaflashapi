package sk.prasa.webapis.picasa.core.command 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.objects.UrlParams;	
	
	/**
	 * Loads the feed, adds event handlers to the receiver. 
	 * Part of the Command Pattern
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class GetFeedCommand implements ICommand
	{
		private var receiver : IReceiver;
		private var params : UrlParams;
		
		/**
		 * Command constructor.
		 * 
		 * @param r IReceiver A IReceiver instance.
		 * @param p UrlParams Parameters to alter the feed url.
		 */
		public function GetFeedCommand(r : IReceiver, p : UrlParams)
		{
			receiver = r;
			params = p;
		}

		/**
		 * Executes the command.
		 * 
		 * @throws Error, generic.
		 */
		public function execute() : void
		{
			var tRequest : URLRequest = params.getURLRequest();

			trace("(" + tRequest.method + ") " + tRequest.url);
		
			var tLoader : URLLoader = new URLLoader();
				tLoader.addEventListener(Event.OPEN, receiver.open);
				tLoader.addEventListener(Event.COMPLETE, receiver.result);
				tLoader.addEventListener(IOErrorEvent.IO_ERROR, receiver.fault);
				tLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, receiver.fault);
				tLoader.addEventListener(ProgressEvent.PROGRESS, receiver.progress);
				tLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, receiver.status);
			
			try
			{
				tLoader.load(tRequest);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}		
	}
}