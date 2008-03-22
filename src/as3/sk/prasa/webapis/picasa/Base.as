package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class Base 
	{
		public var title : String;
		public var id : String;
		public var links : Array;
		public var subtitle : String;
		public var rights : String;
		public var author : Author;
		public var updated : String;
		public var category : Category;
		public var generator : Generator;
		public var icon : String;
		public var logo : String;
		
		public function Base(o : Object)
		{
			links = [];
			
			title = o.title;
			id = o.id;
			links = getLinks(o.link);
			subtitle = o.subtitle;
			rights = o.rights;
			
			author = new Author(o.author.name, o.author.email, o.author.uri);
			updated = o.updated;
			category = new Category(o.category.attributes.term, o.category.attributes.scheme);
			generator = new Generator(o.generator.name, o.generator.version, o.generator.uri);
			icon = o.icon;
			logo = o.logo;
		}
		
		private function getLinks(o : Object) : Array
		{
			var tLinks:Array = [];
			
			for(var a:Number = 0; a < o.length; a++)
			{
				tLinks.push(new Link(o[a].attributes.href, o[a].attributes.type, o[a].attributes.rel));
			}
			
			return tLinks;
		}
		
		public function toString() : String
		{
			return "[Base ... todo]";
		}
	}
}
