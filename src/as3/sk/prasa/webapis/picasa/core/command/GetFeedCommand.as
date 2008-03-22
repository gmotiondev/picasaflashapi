package sk.prasa.webapis.picasa.core.command 
{
	import mx.rpc.IResponder;
	import mx.rpc.Responder;	
	import mx.rpc.AsyncToken;	
	import mx.rpc.http.HTTPService;	
			
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
			
			var tSrv : HTTPService = service.picasaservice_internal::httpService;
				tSrv.url = Auth.FEEDS_POINT + q;
				tSrv.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			
			var tResp : Responder = new Responder(receiver.result, receiver.fault);
			var tToken : AsyncToken = tSrv.send();
				tToken.addResponder(tResp);
		}		
	}
}
