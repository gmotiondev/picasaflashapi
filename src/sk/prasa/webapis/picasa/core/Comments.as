/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

[Event(name="commentsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="commentsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Comments
{
	private var __service;
	
	public function Comments(service:PicasaService)
	{
		__service = service;
	}
	
	// list all comments for specified user
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=comment
	public function user(userid:String):Void
	{
		var tSuffix:String = "user/"+userid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "comment";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, user_complete), false, tSuffix, tUrlParams);
	}
	
	// 
	private function user_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_USER);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseCommentList);
	}
	
	// list comments for specified album
	// http://www.prasa.sk/proxy.php?gws_path=http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5110367185091112897?kind=comment
	public function album(userid:String, albumid:String):Void
	{
		var tSuffix:String = "user/"+userid+"/albumid/"+albumid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "comment";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, album_complete), false, tSuffix, tUrlParams);
	}
	
	private function album_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_ALBUM);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseCommentList);
	}
	
	// list comments for specified photo
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/album/SampleAlbum/photoid/5094407740341564914?kind=comment
	public function photo(userid:String, albumid:String, photoid:String):Void
	{	
		var tSuffix:String = "user/"+userid+"/albumid/"+albumid+"/photoid/"+photoid;
		var tUrlParams:UrlParams = MethodGroupHelper.mergeUrlParams(__service);
			tUrlParams.kind = "comment";	// overwrite!
			tUrlParams.tag = null;
			tUrlParams.q = null;

		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, photo_complete), false, tSuffix, tUrlParams);
	}
	
	// 
	private function photo_complete(event:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMMENTS_GET_PHOTO);

		MethodGroupHelper.processAndDispatch(__service, event.getObject(), tResultEvent, MethodGroupHelper.parseCommentList);
	}
}