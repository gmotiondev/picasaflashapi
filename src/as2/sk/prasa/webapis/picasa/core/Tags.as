import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.command.*;
import sk.prasa.webapis.picasa.core.receiver.*;
import sk.prasa.webapis.picasa.core.receiver.tags.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/lomo
 */

[Event(name="tagsGetUser", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetAlbum", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
[Event(name="tagsGetPhoto", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]

class sk.prasa.webapis.picasa.core.Tags
{
	/**
	 * List all tags for specified user
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=tag 
	 * 
	 * @param userid String Picasaweb user id
	 */
	public function user(userid : String) : Void
	{
		var s : String = "user/" + userid;
		var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
			p.kind = "tag";	// override!
			p.tag = null;
			p.q = null;

		var tReceiver : IReceiver = new TagsUserReceiver();
		var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
		var tInvoker : Invoker = new Invoker();
		
		tInvoker.setCommand(tCommand);
		tInvoker.executeCommand();
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
		var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
			p.kind = "tag";	// override!
			p.tag = null;
			p.q = null;

		var tReceiver : IReceiver = new TagsAlbumReceiver();
		var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
		var tInvoker : Invoker = new Invoker();
		
		tInvoker.setCommand(tCommand);
		tInvoker.executeCommand();
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
		var p : UrlParams = PicasaService.getInstance().mergeUrlParams();
			p.kind = "tag";	// override!
			p.tag = null;
			p.q = null;

		var tReceiver : IReceiver = new TagsPhotoReceiver();
		var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
		var tInvoker : Invoker = new Invoker();
		
		tInvoker.setCommand(tCommand);
		tInvoker.executeCommand();
	}
}
