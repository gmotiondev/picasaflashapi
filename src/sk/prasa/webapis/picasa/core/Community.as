import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
[Event(name="communityGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]	
class sk.prasa.webapis.picasa.core.Community
{
	private var __service : IPicasaService;
	private var __core : MethodGroupHelper;

	public function Community(service : IPicasaService)
	{
		__service = service;
		__core = MethodGroupHelper.getInstance();
	}

	// 
	/**
	 * List photos in community by given query 
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm
	 * 
	 * @param query String Query
	 * @param params String Params to alter the feed url
	 */
	public function search(query : String, params : UrlParams) : Void
	{
		var s : String = "all";
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "photo";	// overwrite!
			p.tag = null;
			p.q = query;

		__core.invokeMethod(__service, Delegate.create(this, search_complete), false, s, p);
	}
	
	private function search_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMUNITY_GET_SEARCH);
		
		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseCommunityPhotoList);
	}
}