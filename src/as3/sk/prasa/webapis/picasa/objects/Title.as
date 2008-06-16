package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.Text;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Title extends Text 
	{
		public function Title(aType : String = null, aValue : String = null)
		{
			super(aType, aValue);
		}
		
		override public function toString() : String
		{
			return "[Title " + super.toString() + "]";
		}
	}
}
