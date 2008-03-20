package sk.prasa.webapis.picasa.core.command 
{
	import flash.net.URLRequest;	
	import flash.events.Event;	
	
	import sk.prasa.webapis.generic.IXMLService;	
	import sk.prasa.webapis.picasa.core.Auth;	
	import sk.prasa.webapis.picasa.PicasaService;	
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	import sk.prasa.webapis.generic.IPicasaService;	
	import sk.prasa.webapis.picasa.core.command.ICommand;
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class LoadFeedCommand implements ICommand 
	{
		private var service : IPicasaService;
		private var receiver : IReceiver;
		private var suffix : String;
		private var params : String;
		
		public function LoadFeedCommand(r : IReceiver, s : String, p : String)
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
			
			var l : IXMLService = service.getXMLService();
				l.addEventListener(Event.COMPLETE, onComplete);
				l.load(new URLRequest(Auth.FEEDS_POINT + q));
		}
		
		private function onComplete(evt : Event) : void
		{
			receiver.complete(evt);
		}
	}
}
