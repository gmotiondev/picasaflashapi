package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.atom.TextNode;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Rights extends TextNode 
	{
		public function Rights(aType : String = null, aValue : String = null)
		{
			super(aType, aValue);
		}
	}
}
