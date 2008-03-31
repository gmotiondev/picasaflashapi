import sk.prasa.webapis.picasa.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.BasicEntry extends Base 
{	
	public var author : Author;
	public var category : Category;
	public var content : Content;
	public var id : String;
	public var links : Array;
	public var published : String;
	public var rights : String;
	public var summary : String;
	public var title : String;
	public var updated : String;
		
	public function BasicEntry(aItem : Object, aParent : Object)
	{
		super(aItem, aParent);
		
		author = new Author(aItem.author.name, aItem.author.email, aItem.author.uri);
		category = new Category(aItem.category.attributes.term, aItem.category.attributes.scheme);
		content = new Content(aItem.content.attributes.type, aItem.content.attributes.src);
		id = aItem.id;
		links = getLinks(aItem);
		published = aItem.published;
		rights = aItem.rights;
		summary = aItem.summary;
		title = aItem.title;
		updated = aItem.updated;
	}
		
	public function toString() : String
	{
		return "" +
			", author=" + author.toString() +
			", category=" + category.toString() +
			", content=" + content.toString() + 
			", id=" + id +
			", links=" + links + 
			", published=" + published + 
			", rights=" + rights + 
			", summary=" + summary +
			", title=" + title +
			", updated=" + updated +
			"";
	}
}
