import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.generic.IServiceBase;

import com.bourre.events.IEvent;

import sk.prasa.webapis.generic.IXMLService;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

interface sk.prasa.webapis.generic.IPicasaService extends IServiceBase
{
	public function getXMLService() : IXMLService

	public function onError(evt : IEvent) : Void
	public function onProgress(evt : IEvent) : Void
	public function onInit(evt : IEvent) : Void
	public function onTimeout(evt : IEvent) : Void
	
	public function mergeUrlParams(request : UrlParams) : UrlParams
}
