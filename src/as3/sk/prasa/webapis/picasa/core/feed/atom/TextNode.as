package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class TextNode 
	{
		public static const TYPE_TEXT : String = "text";
		public static const TYPE_HTML : String = "html";
		public static const TYPE_XHTML : String = "xhtml";

		public var type : String;
		public var value : String;

		public function TextNode(aType : String = null, aValue : String = null)
		{
			type = aType;
			value = aValue;
		}
	}
}
