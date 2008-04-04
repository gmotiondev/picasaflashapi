import sk.prasa.webapis.picasa.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Base
{
	public var parent : Base;

	
	public function Base(aItem : Object, aParent : Object)
	{
		if(aParent != null && aParent != undefined) parent = getParentItem(aParent);
	}
	
	public function getParentItem(item : Object) : Base
	{
		switch(getParentKindType(item))
		{
			case KindType.USER : 	return new User(item);
			case KindType.PHOTO : 	return new Photo(item);
			case KindType.COMMENT : return new Comment(item);
			case KindType.TAG : 	return new Tag(item);
			case KindType.ALBUM : 
			default: return new Album(item);
		}
		
		return null;
	}
		
	public function getParentKindType(item : Object) : String
	{
		return KindType.getKindType((item.category.attributes.term).split("#")[1]);
	}

	private function getLinks(links : Object) : Array
	{
		var tRes : Array = [];
		
		for(var a : Number = 0; a < links.length; a++)
		{
			tRes.push(new Link(links[a].attributes.href, links[a].attributes.type, links[a].attributes.rel));
		}
		
		return tRes;
	}
	
	public function toString() : String
	{
		return "[Base]";
	}
	
	/*public var title : String;
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
	}*/
}
