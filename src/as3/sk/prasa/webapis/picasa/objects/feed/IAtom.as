package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.IMeta;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public interface IAtom 
	{
		function get meta() : IMeta;
		function get entries() : Array;
	}
}
