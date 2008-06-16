package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Text 
	{
		public static const TYPE_PLAIN : String = "plain";
		public static const TYPE_TEXT : String = "text";
		public static const TYPE_HTML : String = "html";
		public static const TYPE_XHTML : String = "xhtml";

		public var type : String;
		public var value : String;

		public function Text(aType : String = null, aValue : String = null)
		{
			type = aType;
			value = aValue;
		}
		
		public function toString() : String
		{
			return "[Text type=" + type + ", value=" + value + "]";
		}
	}
}
