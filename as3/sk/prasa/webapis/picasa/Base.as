package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	internal class Base 
	{
		public var parent : Base;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function Base(aItem : XML, aParent : XML = null)
		{
			if(aParent != null) parent = getParentItem(aParent);
		}
		
		public function getParentItem(item : XML) : Base
		{
			switch(getParentKindType(item))
			{
				case KindType.USER : 	return new User(item);
				case KindType.PHOTO : 	return new Photo(item);
				case KindType.COMMENT : return new Comment(item);
				case KindType.TAG : 	return new Tag(item);
				case KindType.ALBUM :
				default : return new Album(item);
			}
			
			return null;
		}
		
		public function getParentKindType(item : XML) : String
		{
			return KindType.getKindType((item.category.@term).split("#")[1]);
		}

		public function getLinks(item : XML) : Links
		{
			var tRes : Links = new Links();
			
			for each(var link : XML in item.link) {
				tRes.push(new Link(link.@href, link.@type, link.@rel));
			}
			
			return tRes;
		}
		
		public function toString() : String
		{
			return "[Base]";
		}
	}
}
