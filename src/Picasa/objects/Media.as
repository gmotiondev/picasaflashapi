/**
 * @author Michal Gron
 */
 
 /*
 	<media:group>
		<media:title type="plain">Unsorted Lomo</media:title> 
		<media:description type="plain">Unsorted lomos</media:description> 
		<media:keywords /> 
		<media:content url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg" type="image/jpeg" medium="image" /> 
		<media:thumbnail url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg?imgmax=160&crop=1" height="160" width="160" /> 
		<media:credit>Pink-fu</media:credit> 
	</media:group>
 */
 
class Picasa.objects.Media
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
			medium: a["media:content"].attributes.medium
		};
		
		var tNode = (a["media:thumbnail"].length != undefined) ? a["media:thumbnail"][0] : a["media:thumbnail"];
		
		thumbnail = {
			url 	: tNode.attributes.url,
			width 	: tNode.attributes.width,
			height 	: tNode.attributes.height
		};
	}
}
