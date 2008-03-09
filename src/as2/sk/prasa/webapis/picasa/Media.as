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
/*
   1. media:content
   2. media:credit
   3. media:description
   4. media:group
   5. media:keywords
   6. media:thumbnail
   7. media:title
   
  <media:group>
  <media:title type="plain">20070729_01.jpg</media:title> 
  <media:description type="plain">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</media:description> 
  <media:keywords /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s72/20070729_01.jpg" height="54" width="72" /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s144/20070729_01.jpg" height="108" width="144" /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s288/20070729_01.jpg" height="216" width="288" /> 
  <media:content url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/20070729_01.jpg" height="240" width="320" type="image/jpeg" medium="image" /> 
  <media:credit>Pink-fu</media:credit> 
*/