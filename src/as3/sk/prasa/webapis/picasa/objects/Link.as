package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Link 
	{
		public static const REL_ALTERNATE : String = "alternate";
		public static const REL_RELATED : String = "related";
		public static const REL_SELF : String = "self";
		public static const REL_ENCLOSURE : String = "enclosure";
		public static const REL_VIA : String = "via";
		
		public static const REL_PREV : String = "prev";
		public static const REL_NEXT : String = "next";
		public static const REL_FEED : String = "http://schemas.google.com/g/2005#feed";
		public static const REL_SLIDESHOW : String = "http://schemas.google.com/photos/2007#slideshow"; 
		
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
		
		public function toString() : String
		{
			return "[Link " +
				" rel=" + rel + 
				", type=" + type + 
				", hreflang=" + hreflang +
				", href=" + href + 
				", title=" + title +
				", length=" + length + "]";
		}
	}
}
