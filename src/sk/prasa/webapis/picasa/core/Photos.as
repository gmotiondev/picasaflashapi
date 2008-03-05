/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.generic.IPicasaService;

import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

[Event(name="photosGetList", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="photosGetListByTag", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
class sk.prasa.webapis.picasa.core.Photos
{
	private var __service : IPicasaService;
	private var __core : MethodGroupHelper;

	public function Photos(service : IPicasaService)
	{
		__service = service;
		__core = MethodGroupHelper.getInstance();
	}

	// scheme: http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=photo
	// normal: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993
	// private: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/4997359002061176849?kind=photo&authkey=jYNMghEYgL0
	public function list(userid : String, albumid : String, params : UrlParams) : Void
	{
		var s : String = "user/" + userid + "/albumid/" + albumid;
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "photo";	// overwrite!
			p.tag = null;
			p.q = null;
		
		__core.invokeMethod(__service, Delegate.create(this, list_complete), false, s, p);
	}
	
	private function list_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_GET_LIST);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parsePhotoList);	
	}
	
	// by tags: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?tag=resurgere
	public function list_by_tag(userid : String, albumid : String, tag : String, params : UrlParams) : Void
	{
		var s:String = "user/" + userid + "/albumid/" + albumid;
		var p : UrlParams = __service.mergeUrlParams(params);
			p.kind = "photo";	// overwrite!
			p.tag = tag;
			p.q = null;
		
		__core.invokeMethod(__service, Delegate.create(this, list_by_tag_complete), false, s, p);		
	}
	
	private function list_by_tag_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_GET_LIST_BY_TAG);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parsePhotoList);
	}
	
	public function single(userid : String, albumid : String, photoid : String, params : UrlParams) : Void
	{
		trace("Not yet implemented!");
	}
	
	private function single_complete(evt : XMLToObjectEvent) : Void
	{
	}
}
