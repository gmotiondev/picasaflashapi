package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.atom.UserNode;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Author extends UserNode 
	{
		public function Author(aName : String = null, aUri : String = null, aEmail : String = null)
		{
			super(aName, aUri, aEmail);
		}
	}
}
