package sk.prasa.webapis.picasa.core.feed.atom 
{
	import sk.prasa.webapis.picasa.core.feed.atom.IHead;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public interface IAtom 
	{
		function get head() : IHead;
		function get entries() : Array;
	}
}
