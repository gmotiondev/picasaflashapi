package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.Parser;
	import sk.prasa.webapis.picasa.core.feed.atom.IAtom;
	import sk.prasa.webapis.picasa.core.feed.atom.IHead;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Atom extends Parser implements IAtom 
	{
		private var __head : Head;
		private var __entries : Array;
		
		public function Atom(xml : XML)
		{
			super(xml);
		}
		
		public function get head() : IHead
		{
			if (__head == null)
			{
				__head = new Head(XMLList(this.data));
			}
			
			return __head;
		}
		
		public function get entries() : Array
		{
			return null;
		}
	}
}
