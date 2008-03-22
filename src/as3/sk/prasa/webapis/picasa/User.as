package sk.prasa.webapis.picasa 
{	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * User kind doesn't have a parent, it's the master kind
	 */
	
	public class User
	{
		public var id : String;
		public var updated : String;
		public var category : Category;
		public var title : String;
		public var subtitle : String;
		public var icon : String;
		public var links : Array;
		public var author : Author;
		public var generator : Generator;
		public var opensearch : OpenSearch;
		public var gphoto : GPhoto;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function User(item : XML)
		{		
			id = item.id;
			updated = item.updated;
			category = new Category(item.category.@term, item.category.@scheme);
			title = item.title;
			subtitle = item.subtitle;
			icon = item.icon;
			links = getLinks(item);
			author = new Author(item.author.name, item.author.email, item.author.uri);
			generator = new Generator(item.generator, item.generator.@version, item.generator.@uri);
			
			opensearch = new OpenSearch(item);
			gphoto = new GPhoto(item, KindType.USER);
			
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
			return "[User " +
				" id=" + id +
				" ,updated=" + updated +
				" ,category=" + category.toString() +
				" ,title=" + title +
				" ,subtitle=" + subtitle +
				" ,icon=" + icon +
				" ,links=" + links.join("/") +
				" ,author=" + author.toString() +
				" ,generator=" + generator.toString() +
				" ,opensearch=" + opensearch.toString() +
				" ,gphoto=" + gphoto.toString() +
				"]";
		}
	}
}
