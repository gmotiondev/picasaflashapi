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
		albumid 			= o["gphoto:albumid"];
		commentCount 		= parseFloat(o["gphoto:commentCount"]); 
		commentingEnabled 	= o["gphoto:commentingEnabled"] != "false"; 
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
		bytesUsed 	= parseFloat(o["gphoto:bytesUsed"]); 
		location 	= o["gphoto:location"]; 
		name 		= o["gphoto:name"]; 
		numphotos 	= parseFloat(o["gphoto:numphotos"]); 
		numphotosremaining = parseFloat(o["gphoto:numphotosremaining"]);
	}
	
	// photo kind
	private function setPhotoProperties(o:Object):Void
	{
		checksum 	= o["gphoto:checksum"];
		client 		= o["gphoto:client"]; 
		height 		= parseFloat(o["gphoto:height"]); 
		position 	= parseFloat(o["gphoto:position"]); 
		rotation 	= parseFloat(o["gphoto:rotation"]); 
		size 		= parseFloat(o["gphoto:size"]); 
		timestamp 	= parseFloat(o["gphoto:timestamp"]); 
		version 	= o["gphoto:version"]; 
		width 		= parseFloat(o["gphoto:width"]); 
	}
	
	// user kind
	private function setUserProperties(o:Object):Void
	{
		maxPhotosPerAlbum = parseFloat(o["gphoto:maxPhotosPerAlbum"]); 
		nickname 	= o["gphoto:nickname"]; 
		quotacurrent= parseFloat(o["gphoto:quotacurrent"]); 
		quotalimit 	= parseFloat(o["gphoto:quotalimit"]); 
		thumbnail 	= o["gphoto:thumbnail"]; 
		user 		= o["gphoto:user"]; 
	}
	
	// tag kind
	private function setTagProperties(o:Object):Void
	{
		weight = parseFloat(o["gphoto:weight"]);
	}
	
	// comment kind
	private function setCommentProperties(o:Object):Void
	{
		photoid = o["gphoto:photoid"];
	}
	
	public function toString():String
	{
		var tRes:Array = [];
			tRes.push(" albumid=",albumid);
			tRes.push(", commentCount=",commentCount);
			tRes.push(", commentingEnabled=",commentingEnabled);
			tRes.push(", id=",id);
	
		switch(kind)
		{
			case KindType.ALBUM: 
				tRes.push(", access=",access);
				tRes.push(", bytesUsed=",bytesUsed);
				tRes.push(", location=",location);
				tRes.push(", name=",name);
				tRes.push(", numphotos=",numphotos);
				tRes.push(", numphotosremaining=",numphotosremaining);
				break;
			case KindType.PHOTO:
				tRes.push(", checksum=",checksum);
				tRes.push(", client=",client);
				tRes.push(", height=",height);
				tRes.push(", position=",position);
				tRes.push(", rotation=",rotation);
				tRes.push(", size=",size);
				tRes.push(", timestamp=",timestamp);
				tRes.push(", version=",version);
				tRes.push(", width=",width);
				break; 
			case KindType.USER:
				tRes.push(", maxPhotosPerAlbum=",maxPhotosPerAlbum);
				tRes.push(", nickname=",nickname);
				tRes.push(", quotacurrent=",quotacurrent);
				tRes.push(", quotalimit=",quotalimit);
				tRes.push(", thumbnail=",thumbnail);
				tRes.push(", user=",user);
				break;
			case KindType.TAG:
				tRes.push(", weight=",weight);
				break; 
			case KindType.COMMENT:
				tRes.push(", photoid=",photoid);
				break; 
		}
		
		return "[GPhoto "+tRes.join("")+"]";
	}
	
}