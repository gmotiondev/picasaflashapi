/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

[Event(name="albumsGetList", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="albumsGetListByTag", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="albumsGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Albums
{
	private var __service:PicasaService;
	
	public function Albums(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID?kind=album
	public function list(userid:String, params:UrlParams):Void
	{
		var tSuffix:String = "user/"+userid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, params);
			tUrlParams.kind = "album";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_complete), false, tSuffix, tUrlParams);
	}
	
	private function list_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST);

		MethodGroupHelper.processAndDispatch(__service,
											event.getObject(),
											tResultEvent,	
											MethodGroupHelper.parseAlbumList);	
	}
	
	
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=photo&tag=resurgere
	public function list_by_tag(userid:String, tag:String, params:UrlParams):Void
	{
		var tSuffix:String = "user/"+userid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, params);
			tUrlParams.kind = "photo";	// overwrite!
			tUrlParams.tag = tag;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_by_tag_complete), false, tSuffix, tUrlParams);
	}
	
	private function list_by_tag_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST_BY_TAG);
		
		MethodGroupHelper.processAndDispatch(__service,
											event.getObject(),
											tResultEvent,	
											MethodGroupHelper.parsePhotoList);
	}
	
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=photo&q=resurgere
	public function search(userid:String, query:String, params:UrlParams):Void
	{
		var tSuffix:String = "user/"+userid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, params);
			tUrlParams.kind = "photo";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = query;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, search_complete), false, tSuffix, tUrlParams);
	
	}
	
	private function search_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_SEARCH);
		
		MethodGroupHelper.processAndDispatch(__service,
											event.getObject(),
											tResultEvent,	
											MethodGroupHelper.parsePhotoList);
	}
}