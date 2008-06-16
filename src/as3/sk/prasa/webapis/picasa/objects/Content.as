package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Content extends Text 
	{
		public var src : String;
		
		public function Content(aType : String = null, aValue : String = null, aSrc : String = null)
		{
			super(aType, aValue);
			
			src = aSrc;
		}
		
		override public function toString() : String
		{
			return "[Content src=" + src + ", " + super.toString() + "]";
		}
	}
}
