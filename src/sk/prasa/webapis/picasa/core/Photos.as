/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
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
	private var __service:PicasaService;
	
	public function Photos(service:PicasaService)
	{
		__service = service;
	}
	
	// scheme: http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=photo
	// normal: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993
	// private: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/4997359002061176849?kind=photo&authkey=jYNMghEYgL0
	public function list(userid:String, albumid:String, params:UrlParams):Void
	{
		var tSuffix:String = "user/"+userid+"/albumid/"+albumid;
		
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, params);
			tUrlParams.kind = "photo";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;
		
		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_complete), false, tSuffix, tUrlParams);
	}
	
	private function list_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_GET_LIST);

		MethodGroupHelper.processAndDispatch(__service,
											event.getObject(),
											tResultEvent,	
											MethodGroupHelper.parsePhotoList);	
	}
	// by tags: http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?tag=resurgere
	public function list_by_tag(userid:String, albumid:String, tag:String, params:UrlParams):Void
	{
		var tSuffix:String = "user/"+userid+"/albumid/"+albumid;
		
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service, params);
			tUrlParams.kind = "photo";	// overwrite!
			tUrlParams.tag = tag;
			tUrlParams.q = null;
		
		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_by_tag_complete), false, tSuffix, tUrlParams);		
	}
	
	private function list_by_tag_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_GET_LIST_BY_TAG);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parsePhotoList);
	}
	
	//public function single(userid:String, albumid:String, photoid:String, params:UrlParams):Void
	//{
	//}
	
	//private function single_complete(event:XMLToObjectEvent):Void
	//{
	//}
}
