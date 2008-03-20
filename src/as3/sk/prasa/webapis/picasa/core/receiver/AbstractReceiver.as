package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.PicasaError;	
	import sk.prasa.webapis.picasa.events.PicasaResultEvent;	
	import sk.prasa.webapis.picasa.PicasaService;	
	import sk.prasa.webapis.generic.IPicasaService;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class AbstractReceiver 
	{
		private var service : IPicasaService;

		public function AbstractReceiver()
		{
			service = PicasaService.getInstance();
		}
	
		public function process(response : Object, result : PicasaResultEvent, func : Function) : void 
		{
			var tRsp : Object = getResponse(response, func);
	
			result.success = tRsp["success"];
			result.target = tRsp["data"];
			result.error = tRsp["error"];
	
			service.dispatchEvent(result);
		}
		
		private function getResponse(resp : Object, func : Function) : Object
		{
			var tResult : Object = {};
				tResult["data"] = {};
				tResult["error"] = {};
			
			if (resp["error"] == null)
			{
				tResult["success"] = true;
				tResult["data"] = (func == null) ? resp : func(resp);		
			} else
			{
				tResult["success"] = false;
				tResult["error"] = new PicasaError(resp["error"]["message"]);
			}
			
			return tResult;	
		}
	}
}
