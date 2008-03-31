import sk.prasa.webapis.picasa.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.BasicFeed extends Base 
{	
	public var author : Author;
	public var category : Category;
	public var generator : Generator;
	public var icon : String;
	public var id : String;
	public var links : Array;
	//public var logo : String;
	public var rights : String;
	public var subtitle : String;
	public var title : String;
	public var updated : String;
	
	public function BasicFeed(aItem : Object, aParent : Object)
	{
		super(aItem, aParent);
		
		author = new Author(aItem.author.name, aItem.author.email, aItem.author.uri);
		category = new Category(aItem.category.attributes.term, aItem.category.attributes.scheme);
		generator = new Generator(aItem.generator, aItem.generator.attributes.version, aItem.generator.attributes.uri);
		icon = aItem.icon;
		id = aItem.id;
		links = getLinks(aItem);
		//logo = aItem.logo;	//TODO
		rights = aItem.rights;
		subtitle = aItem.subtitle;
		title = aItem.title;
		updated = aItem.updated;
	}
		
	public function toString() : String
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
