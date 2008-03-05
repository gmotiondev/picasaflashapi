import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
[Event(name="albumsGetList", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="albumsGetListByTag", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="albumsGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
class sk.prasa.webapis.picasa.core.Albums
{
	private var __service : IPicasaService;
	private var __core : MethodGroupHelper;

	public function Albums(service : IPicasaService)
	{
		__service = service;
		__core = MethodGroupHelper.getInstance();
	}

	// http://picasaweb.google.com/data/feed/api/user/userID?kind=album
	public function list(userid : String, params : UrlParams) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "album";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, list_complete), false, s, p);
	}
	
	private function list_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseAlbumList);	
	}
	
	
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=photo&tag=resurgere
	public function list_by_tag(userid : String, tag : String, params : UrlParams) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "photo";	// overwrite!
			p.tag = tag;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, list_by_tag_complete), false, s, p);
	}
	
	private function list_by_tag_complete(evt : XMLToObjectEvent):Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST_BY_TAG);
		
		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parsePhotoList);
	}
	
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=photo&q=resurgere
	public function search(userid : String, query : String, params : UrlParams) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "photo";	// overwrite!
			p.tag = null;
			p.q = query;

		__core.invokeMethod(__service, Delegate.create(this, search_complete), false, s, p);
	
	}
	
	private function search_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_SEARCH);
		
		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parsePhotoList);
	}
}