package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Link 
	{
		public static const REL_ALTERNATE : String = "alternate";
		public static const REL_RELATED : String = "related";
		public static const REL_SELF : String = "self";
		public static const REL_ENCLOSURE : String = "enclosure";
		public static const REL_VIA : String = "via";

		public var rel : String;
		public var type : String;
		public var hreflang : String;
		public var href : String;
		public var title : String;
		public var length : Number;
		
		public function Link(aRel : String = null, 
							aType : String = null, 
							aHrefLang : String = null, 
							aHref : String = null, 
							aTitle : String = null, 
							aLength : Number = 0)
		{
			rel = aRel;
			type = aType;
			hreflang = aHrefLang;
			href = aHref;
			title = aTitle;
			length = aLength;
		}
	}
}
