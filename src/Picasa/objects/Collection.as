/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.log.PixlibStringifier;
import Picasa.objects.*;
 
class Picasa.objects.Collection
{
	private var __d:Object;
	private var __g:GPhoto;
	private var __m:Media;
	private var __e:Exif;
	private var __t:String;
	
	public function Collection(a:Object,aType:String)
	{
		__d = a;
		__t = aType;
		
		initialize();
	}
	private function initialize():Void
	{	 
		__g = new GPhoto(__d,__t);
		__m = new Media(__d["media:group"]);
		__e = new Exif(__d["exif:tags"]);
	}
	/**
	 * Returns Photo full id like:
	 * http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/4991254969496895505/photoid/4991255318210936850
	 * @return Full Picasa Photo id.
	 */
	public function getId():String
	{
		return __d["id"];
	}
	/**
	 * Returns Picasa Photo published date like:
	 * 2006-10-29T10:19:48.000Z
	 * @return Picasa Photo published date.
	 */
	public function getPublished():String
	{
		return __d["published"];
	}
	/**
	 * Returns Picasa Photo updated date like:
	 * 2006-10-29T10:19:48.000Z
	 * @return Picasa Photo updated date.
	 */
	public function getUpdated():String
	{
		return __d["updated"];
	}
	/**
	 * !TODO
	 * <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#photo"/>
	 */
	public function getCategory():String
	{	
		return __d["category"];
	}
	/**
	 * Returns Picasa Photo title like:
	 * Untitled-3.jpg
	 * @return Picasa Photo title string.
	 */
	public function getTitle():String
	{
		return __d["title"];
	}
	/**
	 * Returns Picasa Photo summary.
	 * @return Picasa Photo summary string.
	 */
	public function getSummary():String
	{		
		return (__d["summary"] != null) ? __d["summary"] : "";
	}
	/**
	 * Returns a photo thumbnail link
	 * @return Photo thumbnail link url.
	 */
	public function getThumbnailLink():String
	{
		return getMedia().thumbnail.url
	}
	/**
	 * Returns Picasa Photo id string. Not full url id! Simple string like:
	 * 4991255318210936850
	 * @return Picasa Photo id string.
	 */
	public function getIdString():String
	{
		return __g.id;
	}

	/**
	 * true, false
	 */
	public function isCommentingEnabled():Boolean
	{
		return __g.commentingEnabled;
	}
	/**
	 * 0
	 */
	public function getCommentCount():Number
	{
		return parseFloat(__g.commentCount);
	}
	public function getData():Object
	{
		return __d;
	}
	/**
	 * Returns gphoto object.
	 * @return GPhoto object with GPhoto Picasa data
	 */
	 public function getGPhoto():GPhoto
	 {
	 	return __g;
	 }
	/**
	 * Returns exif object.
	 * @return Exif object with Exif Picasa Photo data.
	 */
	public function getExif():Exif
	{
		return __e;
	}
	/**
	 * Returns media object.
	 * @return Media object with Media Picasa data.
	 */
	public function getMedia():Media
	{
		return __m;
	}
}