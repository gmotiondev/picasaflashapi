package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	internal class BasicFeed extends BasicObject
	{
		public var author : Author;
		public var category : Category;
		public var generator : Generator;
		public var icon : String;
		public var id : String;
		public var links : Links;
		//public var logo : String;
		public var rights : String;
		public var subtitle : String;
		public var title : String;
		public var updated : String;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function BasicFeed(aItem : XML, aParent : XML = null)
		{
			super(aItem, aParent);
			
			author = new Author(aItem.author.name, aItem.author.email, aItem.author.uri);
			category = new Category(aItem.category.@term, aItem.category.@scheme);
			generator = new Generator(aItem.generator, aItem.generator.@version, aItem.generator.@uri);
			icon = aItem.icon;
			id = aItem.id;
			links = getLinks(aItem);
			//logo = aItem.logo;	//TODO
			rights = aItem.rights;
			subtitle = aItem.subtitle;
			title = aItem.title;
			updated = aItem.updated;
		}
		
		override public function toString() : String
		{
			return "" +
				", author=" + author.toString() +
				", category=" + category.toString() +
				", generator=" + generator.toString() + 
				", icon=" + icon +
				", id=" + id +
				", links=" + links + 
				//", logo=" + logo +
				", rights=" + rights + 
				", subtitle=" + subtitle +
				", title=" + title +
				", updated=" + updated +
				"";
		}
	}
}