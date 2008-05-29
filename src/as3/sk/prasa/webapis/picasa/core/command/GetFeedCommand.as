package sk.prasa.webapis.picasa.core.command 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class GetFeedCommand implements ICommand
	{
		private var receiver : IReceiver;
		private var suffix : String;
		private var params : String;

		public function GetFeedCommand(r : IReceiver, s : String, p : String)
		{
			receiver = r;
			suffix = (s != "" && s != "") ? s : "";
			params = p;
		}

		public function execute() : void
		{
			var q : String = "" + suffix + "" + params;
			
			trace("loading: " + PicasaService.FEED_BASE_URL + q);
			
			var tReq : URLRequest = new URLRequest(PicasaService.FEED_BASE_URL + q);
			var tLoader : URLLoader = new URLLoader();
				tLoader.addEventListener(Event.OPEN, receiver.open);
				tLoader.addEventListener(Event.COMPLETE, receiver.result);
					
				tLoader.addEventListener(IOErrorEvent.IO_ERROR, receiver.fault);
				tLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, receiver.fault);
				tLoader.addEventListener(ProgressEvent.PROGRESS, receiver.progress);
				tLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, receiver.status);
			
			try
			{
				tLoader.load(tReq);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}		
	}
}
