/**
 *
 */
import sk.prasa.webapis.picasa.KindType;

class sk.prasa.webapis.picasa.GPhoto
{
	private var __kind:KindType;
	 
	// multiple kinds
	public var albumid:String;			// gphoto:albumid
	public var commentCount:Number;		// gphoto:commentCount
	public var commentingEnabled:Boolean;//gphoto:commentingEnabled
	public var id:String;				// gphoto:id
	
	// user kind
	public var maxPhotosPerAlbum:Number;// gphoto:maxPhotosPerAlbum
	public var nickname:String;			// gphoto:nickname
	public var quotacurrent:Number;		// gphoto:quotacurrent
	public var quotalimit:Number;		// gphoto:quotalimit
	public var thumbnail:String;		// gphoto:thumbnail
	public var user:String;				// gphoto:user
	
	// album kind
	public var access:String; 			// gphoto:access
	public var bytesUsed:Number; 		// gphoto:bytesUsed
	public var location:String; 		// gphoto:location
	public var name:String; 			// gphoto:name
	public var numphotos:Number; 		// gphoto:numphotos
	public var numphotosremaining:Number;//gphoto:numphotosremaining

	// photo kind
	public var checksum:String;			// gphoto:checksum
	public var client:String;			// gphoto:client
	public var height:Number;			// gphoto:height
	public var position:Number;			// gphoto:position
	public var rotation:Number;			// gphoto:rotation
	public var size:Number;				// gphoto:size
	public var timestamp:Number;		// gphoto:timestamp
	public var version:String;			// gphoto:version
	public var width:Number;			// gphoto:width

	// comment kind
	public var photoid:String; 			// gphoto:photoid
	
	// tag kind
	public var weight:Number; 			// gphoto:weight
	
	public function GPhoto(o:Object, k:KindType)
	{
		__kind = k;
		
		// multiple kind
		albumid 			= o["gphoto:albumid"]
		commentCount 		= o["gphoto:commentCount"] 
		commentingEnabled 	= o["gphoto:commentingEnabled"] 
		id 					= o["gphoto:id"];
		
		switch(kind)
		{
			case KindType.ALBUM: 	setAlbumProperties(o); 	break;
			case KindType.PHOTO: 	setPhotoProperties(o); 	break;
			case KindType.USER: 	setUserProperties(o); 	break;
			case KindType.TAG: 		setTagProperties(o); 	break;
			case KindType.COMMENT: 	setCommentProperties(o);break;
			default: break; 
		}
	}
	
	public function get kind():KindType
	{
		return __kind;
	}
	
	public function set kind(k:KindType):Void
	{
		__kind = k;
	}
	
	// album kind
	private function setAlbumProperties(o:Object):Void
	{
		access 		= o["gphoto:access"]; 
		bytesUsed 	= o["gphoto:bytesUsed"]; 
		location 	= o["gphoto:location"]; 
		name 		= o["gphoto:name"]; 
		numphotos 	= o["gphoto:numphotos"]; 
		numphotosremaining = o["gphoto:numphotosremaining"];
	}
	
	// photo kind
	private function setPhotoProperties(o:Object):Void
	{
		checksum 	= o["gphoto:checksum"];
		client 		= o["gphoto:client"]; 
		height 		= o["gphoto:height"]; 
		position 	= o["gphoto:position"]; 
		rotation 	= o["gphoto:rotation"]; 
		size 		= o["gphoto:size"]; 
		timestamp 	= o["gphoto:timestamp"]; 
		version 	= o["gphoto:version"]; 
		width 		= o["gphoto:width"]; 
	}
	
	// user kind
	private function setUserProperties(o:Object):Void
	{
		maxPhotosPerAlbum = o["gphoto:maxPhotosPerAlbum"]; 
		nickname 	= o["gphoto:nickname"]; 
		quotacurrent= o["gphoto:quotacurrent"]; 
		quotalimit 	= o["gphoto:quotalimit"]; 
		thumbnail 	= o["gphoto:thumbnail"]; 
		user 		= o["gphoto:user"]; 
	}
	
	// tag kind
	private function setTagProperties(o:Object):Void
	{
		weight = o["gphoto:weight"];
	}
	
	// comment kind
	private function setCommentProperties(o:Object):Void
	{
		photoid = o["gphoto:photoid"];
	}
}