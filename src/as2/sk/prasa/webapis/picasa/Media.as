import sk.prasa.webapis.picasa.MediaContent;
import sk.prasa.webapis.picasa.MediaThumbnail;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Media
{
	public var content : MediaContent;	// media:content
	public var credit : String; 		// media:credit
	public var description : String; 	// media:description
	public var keywords : Array = []; 	// media:keywords
	public var thumbnail : Array = [];	// media:thumbnail	//Array of MediaThumbnail
	public var title : String;			// media:title
	
	public function Media(o:Object)
	{
		content = getMediaContent(o["media:content"]);
		credit = o["media:credit"];
		description = o["media:description"];
		keywords = getKeywords(o["media:keywords"]);
		thumbnail = getThumbnails(o["media:thumbnail"]);
		title = o["title"];
	}
	
	private function getMediaContent(o : Object) : MediaContent
	{
		return new MediaContent(
			o.attributes.url,
			o.attributes.type,
			o.attributes.medium,
			parseFloat(o.attributes.height),
			parseFloat(o.attributes.width),
			parseFloat(o.attributes.fileSize));
	}
	
	private function getKeywords(k : String) : Array
	{
		var tKeywords:String = k.split(" ").join("");
		
		return tKeywords.split(","); 
	}
	
	private function getThumbnails(o : Object) : Array
	{
		var tRes = [];
		
		// if this is just one thumb
		if(o.attributes.url != undefined)
		{
			tRes.push(new MediaThumbnail(o.attributes.url, parseFloat(o.attributes.width), parseFloat(o.attributes.height)));
		} else
		{
			// there are more thumbs
			for(var a : Number = 0; a < o.length; a++)
			{
				tRes.push(new MediaThumbnail(o[a].attributes.url, parseFloat(o[a].attributes.width), parseFloat(o[a].attributes.height)));
			}
		}
		return tRes;
	}
	
	public function toString() : String
	{
		return "[Media content=" + content.toString() + ", credit=" + credit + ", description=" + description + ", keywords=" + keywords.toString() + ", thumbnail=" + thumbnail.toString() + ", title=" + title + "]";
	}
}
