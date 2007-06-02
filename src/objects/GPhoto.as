/**
 * @author Michal Gron
 */
 
 /*
 	//album tags
 	<gphoto:id>5046158866819398449</gphoto:id>
	<gphoto:name>UnsortedLomo</gphoto:name>
	<gphoto:location>Various</gphoto:location>
	<gphoto:access>public</gphoto:access>
	<gphoto:timestamp>1174892400000</gphoto:timestamp>
	<gphoto:numphotos>12</gphoto:numphotos>
	<gphoto:user>thisispinkfu</gphoto:user>
	<gphoto:nickname>Pink-fu</gphoto:nickname>
	<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
	<gphoto:commentCount>0</gphoto:commentCount>
	
	//plus photo tags
	<gphoto:version>1163538320000000</gphoto:version>
	<gphoto:position>0.0</gphoto:position>
	<gphoto:albumid>4997359002061176849</gphoto:albumid>
	<gphoto:width>1024</gphoto:width>
	<gphoto:height>768</gphoto:height>
	<gphoto:size>111360</gphoto:size>
	<gphoto:client/>
	<gphoto:checksum>1d8ae39d</gphoto:checksum>
	
 */
 
	
class com.kvenda.services.objects.GPhoto
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