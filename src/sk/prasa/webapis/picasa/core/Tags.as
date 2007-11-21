/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

[Event(name="tagsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

// http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/lomo

class sk.prasa.webapis.picasa.core.Tags
{
	private var __service:PicasaService;
	
	public function Tags(service:PicasaService)
	{
		__service = service;
	}
	
	// list tags for specified user
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=tag
	public function user(userid:String):Void
	{
		var tSuffix:String = ""+userid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "tag";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, user_complete), false, tSuffix, tUrlParams);
	}
	
	private function user_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_USER);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseTagList);
	}
	
	// list tags for specified album
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?kind=tag
	public function album(userid:String,albumid:String):Void
	{
		var tSuffix:String = ""+userid+"/albumid/"+albumid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "tag";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, album_complete), false, tSuffix, tUrlParams);
	}

	private function album_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_ALBUM);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseTagList);
	}

	// list tags for specified photo
	// with this, the gphoto.weight isn't set!, logical :)
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897/photoid/5110368147163787298?kind=tag
	public function photo(userid:String,albumid:String,photoid:String):Void
	{
		var tSuffix:String = ""+userid+"/albumid/"+albumid+"/photoid/"+photoid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "tag";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, photo_complete), false, tSuffix, tUrlParams);
	}
	
	private function photo_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_PHOTO);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseTagList);
	}
	
}