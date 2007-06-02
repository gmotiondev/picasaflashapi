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
		initialize();	//fill media object and gphoto object
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
	
	public function getId():String
	{
		//<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/4997359002061176849/photoid/4997359032372559890</id>
		return __d["id"];
	}
	public function getThumbnailLink():String
	{
		return __m.thumbnail.url
	}
	public function getPublished():String
	{
		//<published>2006-11-14T21:05:20.000Z</published>
		return __d["published"];
	}
	public function getUpdated():String
	{
		//<updated>2006-11-14T21:05:20.000Z</updated>
		return __d["updated"];
	}
	public function getCategory():Void
	{
		//<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#photo"/>
	}
	public function getTitle():String
	{
		//<title type="text">IMG_5114.jpg</title>
		return __d["title"];
	}
	public function getSummary():String
	{
		//<summary type="text"/>
		return __d["summary"];
	}
	public function getContent():String
	{
		//<content type="image/jpeg" src="http://lh3.google.com/image/thisispinkfu/RVovkBOoABI/AAAAAAAAAF0/f8bdQ4MnPZ0/IMG_5114.jpg"/>
		return __d["content"].attributes.src;
	}
	public function getIdString():String
	{
		return __g.id;
	}
	public function getLink():String
	{
		return getContent();
	}
	public function getAlbumId():String
	{
		return __g.albumid;
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}