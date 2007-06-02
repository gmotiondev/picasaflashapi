import com.bourre.log.PixlibStringifier;

import com.kvenda.services.objects.*;

/**
 * @author Michal Gron
 */
 
 /*
	<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/4997359002061176849/photoid/4997359032372559890</id>
	<published>2006-11-14T21:05:20.000Z</published>
	<updated>2006-11-14T21:05:20.000Z</updated>
	<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#photo"/>
	<title type="text">IMG_5114.jpg</title>
	<summary type="text"/>
	<content type="image/jpeg" src="http://lh3.google.com/image/thisispinkfu/RVovkBOoABI/AAAAAAAAAF0/f8bdQ4MnPZ0/IMG_5114.jpg"/>
	<link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/4997359002061176849/photoid/4997359032372559890"/>
	<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/IPodVideoWhite60GB/photo#4997359032372559890"/>
	<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/4997359002061176849/photoid/4997359032372559890"/>
	<gphoto:id>4997359032372559890</gphoto:id>
	<gphoto:version>1163538320000000</gphoto:version>
	<gphoto:position>0.0</gphoto:position>
	<gphoto:albumid>4997359002061176849</gphoto:albumid>
	<gphoto:width>1024</gphoto:width>
	<gphoto:height>768</gphoto:height>
	<gphoto:size>111360</gphoto:size>
	<gphoto:client/>
	<gphoto:checksum>1d8ae39d</gphoto:checksum>
	<gphoto:timestamp>1163538320000</gphoto:timestamp>
	<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
	<gphoto:commentCount>0</gphoto:commentCount>
	<exif:tags>
		<exif:fstop>2.8</exif:fstop>
		<exif:make>Canon</exif:make>
		<exif:model>Canon PowerShot A410</exif:model>
		<exif:distance>0.0</exif:distance>
		<exif:exposure>0.05</exif:exposure>
		<exif:flash>false</exif:flash>
		<exif:focallength>5.4</exif:focallength>
		<exif:iso>0</exif:iso>
		<exif:time>1111641798000</exif:time>
	</exif:tags>
	<media:group>
		<media:title type="plain">IMG_5114.jpg</media:title>
		<media:description type="plain"/>
		<media:keywords/>
		<media:content url="http://lh3.google.com/image/thisispinkfu/RVovkBOoABI/AAAAAAAAAF0/f8bdQ4MnPZ0/IMG_5114.jpg" type="image/jpeg" medium="image"/>
		<media:thumbnail url="http://lh3.google.com/image/thisispinkfu/RVovkBOoABI/AAAAAAAAAF0/f8bdQ4MnPZ0/IMG_5114.jpg?imgmax=72" height="54" width="72"/>
		<media:thumbnail url="http://lh3.google.com/image/thisispinkfu/RVovkBOoABI/AAAAAAAAAF0/f8bdQ4MnPZ0/IMG_5114.jpg?imgmax=288" height="216" width="288"/>
		<media:credit>Pink-fu</media:credit>
	</media:group> */
class com.kvenda.services.Photo
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
			client	 			: __d["gphoto:client"],			checksum 			: __d["gphoto:checksum"],			timestamp 			: __d["gphoto:timestamp"],
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