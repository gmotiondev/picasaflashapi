package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class GPhoto 
	{
		public var kind : String;
	 
		// multiple kinds
		public var albumid : String;			// gphoto:albumid
		public var commentCount : Number;		// gphoto:commentCount
		public var commentingEnabled : Boolean;	// gphoto:commentingEnabled
		public var id : String;					// gphoto:id
		
		// user kind
		public var maxPhotosPerAlbum : Number;	// gphoto:maxPhotosPerAlbum
		public var nickname : String;			// gphoto:nickname
		public var quotacurrent : Number;		// gphoto:quotacurrent
		public var quotalimit : Number;			// gphoto:quotalimit
		public var thumbnail : String;			// gphoto:thumbnail
		public var user  :String;				// gphoto:user
		
		// album kind
		public var access : String; 			// gphoto:access
		public var bytesUsed : Number; 			// gphoto:bytesUsed
		public var location : String; 			// gphoto:location
		public var name : String; 				// gphoto:name
		public var numphotos : Number; 			// gphoto:numphotos
		public var numphotosremaining : Number;	//gphoto:numphotosremaining
	
		// photo kind
		public var checksum : String;			// gphoto:checksum
		public var client : String;				// gphoto:client
		public var height : Number;				// gphoto:height
		public var position : Number;			// gphoto:position
		public var rotation : Number;			// gphoto:rotation
		public var size : Number;				// gphoto:size
		public var timestamp : Number;			// gphoto:timestamp
		public var version : String;			// gphoto:version
		public var width : Number;				// gphoto:width
	
		// comment kind
		public var photoid : String; 			// gphoto:photoid
		
		// tag kind
		public var weight : Number; 			// gphoto:weight
		
		default xml namespace = "http://schemas.google.com/photos/2007";
		
		public function GPhoto(item : XML, k : String)
		{
			kind = k;
			
			// multiple kind
			albumid 			= item.albumid;
			commentCount 		= item.commentCount; 
			commentingEnabled 	= item.commentingEnabled != "false"; 
			id 					= item.id;
			
			switch(kind)
			{
				case KindType.ALBUM: 	setAlbumProperties(item); 	break;
				case KindType.PHOTO: 	setPhotoProperties(item); 	break;
				case KindType.USER: 	setUserProperties(item); 	break;
				case KindType.TAG: 		setTagProperties(item); 	break;
				case KindType.COMMENT: 	setCommentProperties(item);	break;
				default: break; 
			}
		}
		
		// album kind
		private function setAlbumProperties(item : XML) : void
		{
			access 		= item.access; 
			bytesUsed 	= parseFloat(item.bytesUsed); 
			location 	= item.location; 
			name 		= item.name; 
			numphotos 	= parseFloat(item.numphotos); 
			numphotosremaining = parseFloat(item.numphotosremaining);
		}
		
		// photo kind
		private function setPhotoProperties(item : XML) : void
		{
			checksum 	= item.checksum;
			client 		= item.client; 
			height 		= parseFloat(item.height); 
			position 	= parseFloat(item.position); 
			rotation 	= parseFloat(item.rotation); 
			size 		= parseFloat(item.size); 
			timestamp 	= parseFloat(item.timestamp); 
			version 	= item.version; 
			width 		= parseFloat(item.width); 
		}
		
		// user kind
		private function setUserProperties(item : XML) : void
		{
			maxPhotosPerAlbum = parseFloat(item.maxPhotosPerAlbum); 
			nickname 	= item.nickname; 
			quotacurrent= parseFloat(item.quotacurrent); 
			quotalimit 	= parseFloat(item.quotalimit); 
			thumbnail 	= item.thumbnail; 
			user 		= item.user; 
		}
		
		// tag kind
		private function setTagProperties(item : XML) : void
		{
			weight = parseFloat(item.weight);
		}
		
		// comment kind
		private function setCommentProperties(item : XML) : void
		{
			photoid = item.photoid;
		}
		
		public function toString() : String
		{
			var tRes : Array = [];
				tRes.push(" albumid=", albumid);
				tRes.push(", commentCount=", commentCount);
				tRes.push(", commentingEnabled=", commentingEnabled);
				tRes.push(", id=", id);
		
			switch(kind)
			{
				case KindType.ALBUM: 
					tRes.push(", access=", access);
					tRes.push(", bytesUsed=", bytesUsed);
					tRes.push(", location=", location);
					tRes.push(", name=", name);
					tRes.push(", numphotos=", numphotos);
					tRes.push(", numphotosremaining=", numphotosremaining);
					break;
				case KindType.PHOTO:
					tRes.push(", checksum=", checksum);
					tRes.push(", client=", client);
					tRes.push(", height=", height);
					tRes.push(", position=", position);
					tRes.push(", rotation=", rotation);
					tRes.push(", size=", size);
					tRes.push(", timestamp=", timestamp);
					tRes.push(", version=", version);
					tRes.push(", width=", width);
					break; 
				case KindType.USER:
					tRes.push(", maxPhotosPerAlbum=", maxPhotosPerAlbum);
					tRes.push(", nickname=", nickname);
					tRes.push(", quotacurrent=", quotacurrent);
					tRes.push(", quotalimit=", quotalimit);
					tRes.push(", thumbnail=", thumbnail);
					tRes.push(", user=", user);
					break;
				case KindType.TAG:
					tRes.push(", weight=", weight);
					break; 
				case KindType.COMMENT:
					tRes.push(", photoid=", photoid);
					break; 
			}
			
			return "[GPhoto " + tRes.join("") + "]";
		}
	}
}
