/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Fine tune with this:
 * http://code.google.com/apis/picasaweb/reference.html
 */
import Picasa.objects.BasicObject;

class Picasa.objects.Media extends BasicObject
{	
	public var title, description, keywords, credit:String;
	public var content, thumbnail:Object;
	
	public function Media(a:Object)
	{
		title 		= a["media:title"];
		description = a["media:description"];
		keywords 	= a["media:keywords"];
		credit 		= a["media:credit"];
		
		content = {
			url: 	a["media:content"].attributes.url,
			type: 	a["media:content"].attributes.type,
			medium: a["media:content"].attributes.medium,
			width: 	a["media:content"].attributes.width,
			height:	a["media:content"].attributes.height
			
		};

		//var tNode = (a["media:thumbnail"].length != undefined) ? a["media:thumbnail"][0] : a["media:thumbnail"];
		
		thumbnail = {
			url 	: a["media:thumbnail"].attributes.url,
			width 	: a["media:thumbnail"].attributes.width,
			height 	: a["media:thumbnail"].attributes.height
		};
	}
}
