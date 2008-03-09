import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/lomo
 */

[Event(name="tagsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
class sk.prasa.webapis.picasa.core.Tags
{
	private var __service : IPicasaService;
	private var __core : MethodGroupHelper;

	public function Tags(service : IPicasaService)
	{
		__service = service;
		__core = MethodGroupHelper.getInstance();
	}

	/**
	 * List all tags for specified user
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=tag 
	 * 
	 * @param userid String Picasaweb user id
	 */
	public function user(userid : String) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "tag";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, user_complete), false, s, p);
	}
	
	private function user_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_USER);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseTagList);
	}
	
	/**
	 * List tags for specified album  
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=tag 
	 * 
	 * @param userid String Picasaweb user id
	 * @param albumid String Picasaweb album id
	 */
	public function album(userid : String, albumid : String) : Void
	{
		var s : String = "user/" + userid + "/albumid/" + albumid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "tag";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, album_complete), false, s, p);
	}

	private function album_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_ALBUM);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseTagList);
	}

	/**
	 * List tags for specified photo
	 *  - with this, the gphoto.weight isn't set!, logical :)  
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID/photoid/photiID?kind=tag 
	 * 
	 * @param userid String Picasaweb user id
	 * @param albumid String Picasaweb album id
	 * @param photoid String Picasaweb photo id
	 */
	public function photo(userid : String, albumid : String, photoid : String) : Void
	{
		var s : String = "user/" + userid + "/albumid/" + albumid + "/photoid/" + photoid;
		var p : UrlParams = __service.mergeUrlParams();
			p.kind = "tag";	// overwrite!
			p.tag = null;
			p.q = null;

		__core.invokeMethod(__service, Delegate.create(this, photo_complete), false, s, p);
	}
	
	private function photo_complete(evt : XMLToObjectEvent) : Void
	{
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.TAGS_GET_PHOTO);

		__core.processAndDispatch(__service, evt.getObject(), tEvt, __core.parseTagList);
	}
}