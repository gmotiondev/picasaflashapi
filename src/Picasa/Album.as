import com.bourre.log.PixlibStringifier;

import Picasa.objects.Media;
import Picasa.objects.GPhoto;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.Album
{
	private var __d:Object;
	private var __g:GPhoto;
	private var __m:Media;
	
	//public var id:String;
	
	public function Album(a:Object)
	{
		__d = a;
		initialize();
	}
	
	private function initialize()
	{
		__g = new GPhoto({
			id 					: __d["gphoto:id"],
			name 				: __d["gphoto:name"],
			location 			: __d["gphoto:location"],
			access 				: __d["gphoto:access"],
			timestamp 			: __d["gphoto:timestamp"],
			numphotos 			: __d["gphoto:numphotos"],
			user 				: __d["gphoto:user"],
			nickname 			: __d["gphoto:nickname"],
			commentingEnabled 	: __d["gphoto:commentingEnabled"],
			commentCount 		: __d["gphoto:commentCount"]
		});
		
		__m = new Media(__d["media:group"]);
	}
	/**
	 * 	 */
	public function getId():String
	{
		return __d["id"];
	}
	/**
	 * 	 */
	public function getThumbnailLink():String
	{
		return __m.thumbnail.url;
	}
	/**
	 * 	 */
	public function getIdString():String
	{
		return __g.id;
	}
	/**
	 * 	 */
	public function getPublished():String
	{
		return __d["published"];
	}
	/**
	 * 	 */
	public function getUpdated():String
	{
		return __d["updated"];
	}
	/**
	 * 	 */
	public function getCategory():String
	{
		return __d["category"];
	}
	/**
	 * 	 */
	public function getTitle():String
	{
		return __d["title"];
	}
	/**
	 * 	 */
	public function getSummary():String
	{
		return __d["summary"];
	}
	/**
	 * public	 */
	public function getRights():String
	{
		return __d["rights"];
	}
	/**
	 * Pink-fu	 */
	public function getAuthorName():String
	{
		return __d["author"]["name"];
	}
	/**
	 * http://picasaweb.google.com/thisispinkfu	 */
	public function getAuthorUri():String
	{
		return __d["author"]["uri"];
	}
	/**
	 * http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5046158866819398449	 */
	public function getLink():String
	{
		return __d["link"][0].attributes.href;
	}
	/**
	 * UnsortedLomo	 */
	public function getAlbumName():String
	{
		return __g.name;
	}
	/**
	 * Various	 */
	public function getLocation():String
	{
		return __g.location;
	}
	/**
	 * public	 */
	public function getAccess():String
	{
		return __g.access;
	}
	/**
	 * 1174892400000	 */
	public function getTimestamp():Number
	{
		return Number(__g.timestamp);
	}
	/**
	 * 12	 */
	public function getPhotosCount():Number
	{
		return parseFloat(__g.numphotos);
	}
	/**
	 * !TODO (if logged in only variable?)
	 * 488	 */
	//public function getRemainingPhotosCount():Number
	//{
	//	return parseInt(__g.numphotosremaining);
	//}
	/**
	 * !TODO (if logged in only variable?)
	 * 1203384	 */
	//public function getBytesUsed():Number
	//{
		//return __g.bytesUsed;
	//}
	/**
	 * thisispinkfu	 */
	public function	getUser():String
	{
		return __g.user;
	}
	/**
	 * Pink-fu	 */
	public function getNickname():String
	{
		return __g.nickname;
	}
	/**
	 * true,false	 */
	public function isCommentingEnabled():Boolean
	{
		return (__g.commentingEnabled == "true");
	}
	/**
	 * 0	 */	
	public function getCommentCount():Number
	{
		return parseFloat(__g.commentCount);
	}	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}