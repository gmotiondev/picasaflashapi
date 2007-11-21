/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

[Event(name="communityGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
class sk.prasa.webapis.picasa.core.Community
{
	private var __service:PicasaService;
	
	public function Community(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm&max-results=10
	public function search(query:String,url_params:UrlParams):Void
	{
		var tSuffix:String = "all";
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, url_params);
			tUrlParams.kind = "photo";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = query;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, search_complete), false, tSuffix, tUrlParams);
	}
	
	private function search_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMUNITY_GET_SEARCH);
		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseCommunityPhotoList);
	}
}