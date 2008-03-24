package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class Base 
	{	
		private var parent : Base;
		
		public function Base(item : XML)
		{
			parent = getParentItem(item);
		}
		
		public function getParentItem(item : XML) : Base
		{
			switch(getParentKindType(item))
			{
				case KindType.ALBUM : 	return new Album(item);
				case KindType.PHOTO : 	return new Photo(item);
				case KindType.COMMENT : return new Comment(item);
				case KindType.TAG : 	return new Tag(item);
			}
		}
		
		public function getParentKindType(item : XML) : String
		{
			return KindType.getKindType((item.category.@term).split("#")[1]);
		}

		private function getLinks(item : XML) : Array
		{
			var tRes : Array = [];
			
			for each(var link : XML in item.link) {
				tRes.push(new Link(link.@href, link.@type, link.@rel));
			}
			
			return tRes;
		}
		
		public function toString() : String
		{
			return "[Base ... todo]";
		}
	}
}
