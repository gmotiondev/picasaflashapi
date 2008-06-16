package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Category 
	{
		public var term : String;
		public var scheme : String;
		public var label : String;
		
		public function Category(aTerm : String = null, aScheme : String = null, aLabel : String = null)
		{
			term = aTerm;
			scheme = aScheme;
			label = aLabel;
		}
		
		public function toString() : String
		{
			return "[Category " +
				" term=" + term + 
				", scheme=" + scheme +
				", label=" + label + 
				"]";
		}
	}
}
