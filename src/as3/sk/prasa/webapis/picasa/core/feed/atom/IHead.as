package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IHead 
	{
		function get title() : Title;
		function get link() : Link;
	}
}
