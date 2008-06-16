package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.Title;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Subtitle extends Title 
	{
		public function Subtitle(aType : String = null, aValue : String = null)
		{
			super(aType, aValue);
		}
		
		override public function toString() : String
		{
			return "[Subtitle " + super.toString() + "]";
		}
	}
}
