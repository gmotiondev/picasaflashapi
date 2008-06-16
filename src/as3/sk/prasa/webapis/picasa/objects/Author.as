package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.User;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Author extends User 
	{
		public function Author(aName : String = null, aUri : String = null, aEmail : String = null)
		{
			super(aName, aUri, aEmail);
		}
		
		override public function toString() : String
		{
			return "[Author " + super.toString() + "]";
		} 
	}
}
