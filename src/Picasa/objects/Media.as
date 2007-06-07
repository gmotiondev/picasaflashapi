import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Fine tune with this:
 * http://code.google.com/apis/picasaweb/reference.html
 */

class Picasa.objects.Media
{	
	public var title, description, keywords, credit:String;
	public var content, thumbnail:Object;
	public var thumbnail_s, thumbnail_m, thumbnail_l;
	
	public function Media(a:Object)
	{
		title 		= a["media:title"];
		description = a["media:description"];
		keywords 	= a["media:keywords"];
		credit 		= a["media:credit"];
		
		content = {
			url: 	a["media:content"].attributes.url,
			type: 	a["media:content"].attributes.type,
			medium: a["media:content"].attributes.medium
		};

		var tNode = (a["media:thumbnail"].length != undefined) ? a["media:thumbnail"][0] : a["media:thumbnail"];
		
		thumbnail = {
			url 	: tNode.attributes.url,
			width 	: tNode.attributes.width,
			height 	: tNode.attributes.height
		};

		thumbnail_s = {
			url : content.url+"?imgmax=72"
		};
		thumbnail_m = {
			url : content.url+"?imgmax=144"
		};
		thumbnail_l = {
			url : content.url+"?imgmax=288"
		};
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}
