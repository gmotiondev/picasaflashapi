package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Contributor extends User 
	{
		public function Contributor(aName : String = null, aUri : String = null, aEmail : String = null)
		{
			super(aName, aUri, aEmail);
		}
		
		override public function toString() : String
		{
			return "[Contributor " + super.toString() + "]";
		}
	}
}
