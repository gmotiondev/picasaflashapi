import sk.prasa.webapis.generic.IPicasaService;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.AbstractReceiver 
{
	private var service : IPicasaService;

	public function AbstractReceiver()
	{
		service = PicasaService.getInstance();
	}

	public function process(response : Object, result : PicasaResultEvent, func : Function) : Void 
	{
		var tRsp : Object = getResponse(response, func);

		result.success = tRsp["success"];
		result.data = tRsp["data"];
		result.error = tRsp["error"];

		service.broadcastEvent(result);
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
