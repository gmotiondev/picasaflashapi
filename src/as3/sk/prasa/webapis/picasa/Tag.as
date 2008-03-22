package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Tag
	{
		public var id : String;
		public var updated : String;
		public var category : Category;
		public var title : String;
		public var summary : String;
		public var links : Array;
		public var author : Author;
		public var gphoto : GPhoto;
		
		public var user : User;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function Tag(item : XML, parent : XML = null)
		{
			if(parent != null) user = new User(parent);
			
			id = item.id;
			updated = item.updated;
			category = new Category(item.category.@term, item.category.@scheme);
			title = item.title;
			summary = item.summary;
			links = getLinks(item);
			author = new Author(item.author.name, item.author.email, item.author.uri);
			gphoto = new GPhoto(item, KindType.TAG);
			
			trace(toString());
		}
		
		//TODO : test this please!
		private function getLinks(item : XML) : Array
		{
			var tRes : Array = [];
			
			for each(var link : XML in item.link)
			{
				tRes.push(new Link(link.@href, link.@type, link.@rel));
			}
			
			return tRes;
		}
		
		public function toString() : String
		{
			return "[Tag " +
				" id=" + id +
				" ,updated=" + updated +
				" ,category=" + category.toString() +
				" ,title=" + title +
				" ,summary=" + summary +
				" ,links=" + links.join("/") +
				" ,author=" + author.toString() +
				" ,gphoto=" + gphoto.toString() +
				"]";
		} 
	}
}

/*
<entry>
	<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/bratislava</id>
	<updated>1970-01-01T00:23:48.000Z</updated>
	<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#tag"/>
	<title type="text">bratislava</title>
	<summary type="text">bratislava</summary>
	<link rel="alternate" type="text/html" href="http://picasaweb.google.com/lh/searchbrowse?q=bratislava&amp;psc=G&amp;uname=thisispinkfu&amp;filter=0"/>
	<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/bratislava"/>
	<author>
		<name>Pink-fu</name>
		<uri>http://picasaweb.google.com/thisispinkfu</uri>
	</author>
	<gphoto:weight>8</gphoto:weight>
</entry>

*/