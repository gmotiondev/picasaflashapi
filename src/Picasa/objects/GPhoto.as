/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
	
class Picasa.objects.GPhoto
{
	public var id, name, location, access, timestamp, numphotos, user, nickname, commentingEnabled,commentCount;
	public var version, position,albumid,width,height,size,client,checksum;
	
	public function GPhoto(a:Object)
	{	
		//album
		id 					= String(a["id"]);
		name 				= String(a["name"]);
		location 			= String(a["location"]);
		access 				= String(a["access"]);
		timestamp 			= Number(a["timestamp"]);
		numphotos 			= Number(a["numphotos"]);
		user 				= String(a["user"]);
		nickname 			= String(a["nickname"]);
		commentingEnabled 	= String(a["commentingEnabled"]);
		commentCount 		= Number(a["commentCount"]);
		
		//plus some from photo
		version 	= String(a["version"]);
		position 	= String(a["position"]);
		albumid 	= String(a["albumid"]);
		width 		= Number(a["width"]);
		height 		= Number(a["height"]);
		size 		= Number(a["size"]);
		client 		= String(a["client"]);
		checksum 	= String(a["checksum"]);
	}
}