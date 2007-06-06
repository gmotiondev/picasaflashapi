import com.bourre.log.PixlibStringifier;

import Picasa.objects.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.Photo
{	
	private var __d:Object;
	private var __g:GPhoto;
	private var __m:Media;
	private var __e:Exif;
	
	public function Photo(a:Object)
	{
		__d = a;
		initialize();
	}
	
	private function initialize()
	{	
		__g = new GPhoto({
			id 					: __d["gphoto:id"],
			version 			: __d["gphoto:version"],
			position 			: __d["gphoto:position"],
			albumid 			: __d["gphoto:albumid"],
			width 				: __d["gphoto:width"],
			height	 			: __d["gphoto:height"],
			size 				: __d["gphoto:size"],
			client	 			: __d["gphoto:client"],
			checksum 			: __d["gphoto:checksum"],
			timestamp 			: __d["gphoto:timestamp"],
			commentingEnabled 	: __d["gphoto:commentingEnabled"],
			commentCount 		: __d["gphoto:commentCount"]
		});
		__e = new Exif(__d["exif:tags"]);
		__m = new Media(__d["media:group"]);
	}
	
	/**
	 * Returns Photo full id like:
	 * http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/4991254969496895505/photoid/4991255318210936850
	 * @return Full Picasa Photo id.	 */
	public function getId():String
	{
		return __d["id"];
	}
	public function getThumbnailLink():String
	{
		return getMedia().thumbnail.url
	}
	public function getThumbnailsLinks():Object{
		return {
			s : getMedia().thumbnail_s,
			m : getMedia().thumbnail_m,
			l : getMedia().thumbnail_l
		}
	}
	/**
	 * Returns Picasa Photo published date like:
	 * 2006-10-29T10:19:48.000Z
	 * @return Picasa Photo published date.	 */
	public function getPublished():String
	{
		return __d["published"];
	}
	/**
	 * Returns Picasa Photo updated date like:
	 * 2006-10-29T10:19:48.000Z
	 * @return Picasa Photo updated date.	 */
	public function getUpdated():String
	{
		return __d["updated"];
	}
	/**
	 * !TODO
	 * <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#photo"/>	 */
	public function getCategory():Void
	{	
	}
	/**
	 * Returns Picasa Photo title like:
	 * Untitled-3.jpg
	 * @return Picasa Photo title string.	 */
	public function getTitle():String
	{
		return __d["title"];
	}
	/**
	 * Returns Picasa Photo summary.
	 * @return Picasa Photo summary string.	 */
	public function getSummary():String
	{		
		return (__d["summary"] != null) ? __d["summary"] : "";
	}
	/**
	 * Returns Picasa Photo url like:
	 * http://lh3.google.com/image/thisispinkfu/RUSARGE-ABI/AAAAAAAAAAk/bC10dIK1qlo/Untitled-3.jpg
	 * @return Picasa Photo url string.	 */
	public function getContent():String
	{
		return __d["content"].attributes.src;
	}
	/**
	 * Returns Picasa Photo id string. Not full url id! Simple string like:
	 * 4991255318210936850
	 * @return Picasa Photo id string.	 */
	public function getIdString():String
	{
		return __g.id;
	}
	/**
	 * Same as getContent();
	 * 
	 * Returns Picasa Photo url like:
	 * http://lh3.google.com/image/thisispinkfu/RUSARGE-ABI/AAAAAAAAAAk/bC10dIK1qlo/Untitled-3.jpg
	 * @return Picasa Photo url string.	 */
	public function getLink():String
	{
		return getContent();
	}
	/**
	 * Returns Picasa Album id where the Picasa Photo is stored.
	 * @return Picasa Album id.	 */
	public function getAlbumId():String
	{
		return __g.albumid;
	}
	/** like:
	 * 1162117188000000
	 * @return 	 */
	public function getVersion():String
	{
		return __g.version;
	}
	/** 
	 * like:
	 * 0.0	 */
	public function getPosition():Object
	{
		return {x:__g.position.split(".")[0], y: __g.position.split(".")[1]};
	}
	/**
	 * 1024	 */
	public function getWidth():Number
	{
		return parseFloat(__g.width);
	}
	/**
	 * 713	 */
	public function getHeight():Number
	{
		return parseFloat(__g.height);
	}
	/**
	 * 77271	 */
	public function getSize():Number
	{
		return parseFloat(__g.size);
	}
	/**
	 * 	 */
	public function getClient():String
	{
		return __g.client;
	}
	/**
	 * 572b6066	 */
	public function getChecksum():String
	{
		return __g.checksum;
	}
	/**
	 * 1162117188000	 */
	public function getTimestamp():Number
	{
		return Number(__g.timestamp);
	}
	/**
	 * true, false	 */
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
	 * @return Media object with Media Picasa Photo data.	 */
	public function getMedia():Media
	{
		return __m;
	}
	/**
	 * 	 */
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}