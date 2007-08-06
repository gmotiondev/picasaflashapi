import com.bourre.log.PixlibStringifier;
import Picasa.objects.ObjectList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * http://code.google.com/apis/picasaweb/reference.html
 */

class Picasa.objects.GPhoto
{
	public var id, name, location, access, timestamp, user, nickname:String;
	public var version, albumid, client, checksum, photoid, thumbnail:String;
	public var numphotos, commentCount, width, height, size, weight, position:Number;
	public var bytesUsed, numphotosremaining, rotation, maxPhotosPerAlbum, quotacurrent, quotalimit:Number;
	public var commentingEnabled:Boolean;
	
	public function GPhoto(a:Object,t:String)
	{	
		switch(t)
		{
			case ObjectList.ALBUM:
				access 				= String(a["gphoto:access"]);
				bytesUsed 			= Number(a["gphoto:bytesUsed"]);
				location 			= String(a["gphoto:location"]);
				name 				= String(a["gphoto:name"]);
				numphotos 			= Number(a["gphoto:numphotos"]);
				numphotosremaining 	= Number(a["gphoto:numphotosremaining"]);
				commentCount 		= Number(a["gphoto:commentCount"]);
				commentingEnabled 	= Boolean(a["gphoto:commentingEnabled"] == "true");
				id 					= String(a["gphoto:id"]);				
				break;
			case ObjectList.PHOTO:
				checksum 			= String(a["gphoto:checksum"]);
				client 				= String(a["gphoto:client"]);
				height 				= Number(a["gphoto:height"]);
				position 			= parseFloat(a["gphoto:position"]);
				rotation 			= Number(a["gphoto:rotation"]);
				size 				= Number(a["gphoto:size"]);
				timestamp			= Number(a["gphoto:timestamp"]);
				version 			= String(a["gphoto:version"]);
				width 				= Number(a["gphoto:width"]);
				albumid 			= String(a["gphoto:albumid"]);
				commentCount 		= Number(a["gphoto:commentCount"]);
				commentingEnabled 	= Boolean(a["gphoto:commentingEnabled"] == "true");
				id 					= String(a["gphoto:id"]);	
				break;
			case ObjectList.USER:
				maxPhotosPerAlbum 	= Number(a["gphoto:maxPhotosPerAlbum"]);
				nickname			= String(a["gphoto:nickname"]);
				quotacurrent 		= Number(a["gphoto:quotacurrent"]);
				quotalimit 			= Number(a["gphoto:quotalimit"]);
				thumbnail 			= String(a["gphoto:thumbnail"]);
				user 				= String(a["gphoto:user"]);
				break;
			case ObjectList.COMMENT:
				photoid 			= String(a["gphoto:photoid"]);
				albumid 			= String(a["gphoto:albumid"]);
				id 					= String(a["gphoto:id"]);
				break;
			case ObjectList.TAG:
		    	weight 				= Number(a["gphoto:weight"]);
				break
			default:
				trace("GPhoto object type not defined!");
		}	
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}