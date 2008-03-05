import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

[Event(name="commentsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Comments
{
	private var __service : IPicasaService;
	private var __core : MethodGroupHelper;

	public function Comments(service : IPicasaService)
	{
		__service = service;
		__core = MethodGroupHelper.getInstance();
	}

	// list all comments for specified user
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=comment
	public function user(userid : String) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "comment";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, user_complete), false, s, p);
	}
	
	// 
	private function user_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_USER);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseCommentList);
	}
	
	// list comments for specified album
	// http://www.prasa.sk/proxy.php?gws_path=http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?kind=comment
	public function album(userid : String, albumid : String) : Void
	{
		var s : String = "user/" + userid + "/albumid/" + albumid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "comment";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, album_complete), false, s, p);
	}
	
	private function album_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_ALBUM);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseCommentList);
	}
	
	// list comments for specified photo
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/album/SampleAlbum/photoid/5094407740341564914?kind=comment
	public function photo(userid : String, albumid : String, photoid : String) : Void
	{	
		var s : String = "user/" + userid + "/albumid/" + albumid + "/photoid/" + photoid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "comment";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, photo_complete), false, s, p);
	}
	
	// 
	private function photo_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_PHOTO);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseCommentList);
	}
}