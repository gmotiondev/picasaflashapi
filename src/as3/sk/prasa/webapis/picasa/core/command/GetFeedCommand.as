package sk.prasa.webapis.picasa.core.command 
{
	import flash.events.IOErrorEvent;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.net.URLLoader;			

	import sk.prasa.webapis.picasa.core.Auth;	
	import sk.prasa.webapis.picasa.PicasaService;	
	import sk.prasa.webapis.picasa.picasaservice_internal;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;		
	import sk.prasa.webapis.picasa.core.command.ICommand;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class GetFeedCommand implements ICommand
	{
		private var service : PicasaService;
		private var receiver : IReceiver;
		private var suffix : String;
		private var params : String;
		
		public function GetFeedCommand(r : IReceiver, s : String, p : String)
		{
			service = PicasaService.getInstance();
			receiver = r;
			suffix = (s != "" && s != "") ? s : "";
			params = p;
		}
		
		public function execute() : void
		{
			var q : String = "" + suffix + "" + params;
			
			trace("loading: " + Auth.FEEDS_POINT + q);
			
			var tReq : URLRequest = new URLRequest(Auth.FEEDS_POINT + q);
			var tSrv : URLLoader = service.picasaservice_internal::service;
				tSrv.addEventListener(Event.COMPLETE, receiver.result);
				tSrv.addEventListener(IOErrorEvent.IO_ERROR, receiver.fault);
			
			try
			{
				tSrv.load(tReq);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}		
	}
}
