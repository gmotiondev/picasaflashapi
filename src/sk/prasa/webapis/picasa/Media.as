/**
 *
 */
import sk.prasa.webapis.picasa.MediaContent;
import sk.prasa.webapis.picasa.MediaThumbnail;

class sk.prasa.webapis.picasa.Media
{
	private var __content:MediaContent;	// media:content
	private var __credit:String; 			// media:credit
	private var __description:String; 		// media:description
	private var __keywords:Array = []; 		// media:keywords
	private var __thumbnail:Array = [];			// media:thumbnail	//Array of MediaThumbnail
	private var __title:String;			// media:title
	
	public function Media(o:Object)
	{
		__content = getMediaContent(o["media:content"]);
		__credit = o["media:credit"];
		__description = o["media:description"]
		__keywords = getKeywords(o["media:keywords"]);
		__thumbnail = getThumbnails(o["media:thumbnail"])
		__title = o["title"];
	}
	
	public function get content():MediaContent
	{
		return __content;
	}
	
	public function set content(v:MediaContent)
	{
		__content = v;
	}
	
	public function get credit():String
	{
		return __credit;
	}
	
	public function set credit(v:String)
	{
		__credit = v;
	}
	
	public function get description():String
	{
		return __description;
	}
	
	public function set description(v:String)
	{
		__description = v;
	}
	
	public function get keywords():Array
	{
		return __keywords;
	}
	
	public function set keywords(v:Array)
	{
		__keywords = v;
	}
	
	public function get thumbnail():Array
	{
		return __thumbnail;
	}
	
	public function set thumbnail(v:Array)
	{
		__thumbnail = v;
	}
	
	public function get title():String
	{
		return __title;
	}
	
	public function set title(v:String)
	{
		__title = v;
	}
	
	private function getMediaContent(o:Object):MediaContent
	{
		return new MediaContent(
			o.attributes.url,
			o.attributes.type,
			o.attributes.medium,
			parseFloat(o.attributes.height),
			parseFloat(o.attributes.width),
			parseFloat(o.attributes.fileSize));
	}
	
	private function getKeywords(k:String):Array
	{
		var tKeywords:String = k.split(" ").join("");
		
		return tKeywords.split(","); 
	}
	
	private function getThumbnails(o:Object):Array
	{
		var tRes = [];
		
			// if this is just one thumb
		if(o.attributes.url != undefined)
		{
			tRes.push(new MediaThumbnail(o.attributes.url, parseFloat(o.attributes.width), parseFloat(o.attributes.height)));
		} else
		{
			// there are more thumbs
			for(var a:Number = 0; a < o.length; a++)
			{
				tRes.push(new MediaThumbnail(o[a].attributes.url, parseFloat(o[a].attributes.width), parseFloat(o[a].attributes.height)));
			}
		}
		return tRes;
	}
	
	public function toString():String
	{
		return "[Media content="+content.toString()+", credit="+credit+", description="+description+", keywords="+keywords.toString()+", thumbnail="+thumbnail.toString()+", title="+title+"]";
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