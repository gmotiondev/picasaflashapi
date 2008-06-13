package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.atom.TextNode;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Content extends TextNode 
	{
		public var src : String;
		
		public function Content(aType : String = null, aValue : String = null, aSrc : String = null)
		{
			super(aType, aValue);
			
			src = aSrc;
		}
	}
}
