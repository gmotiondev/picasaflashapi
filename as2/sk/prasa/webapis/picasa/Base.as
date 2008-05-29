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

	private function getLinks(links : Object) : Links
	{
		var tRes : Links = new Links();
		
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
}