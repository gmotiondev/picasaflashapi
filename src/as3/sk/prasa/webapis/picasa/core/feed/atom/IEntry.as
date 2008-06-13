package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public interface IEntry 
	{
		function get title() : String;
		function get links() : Array;
		function get published() : Date;
		function get authors() : Array;
		function get content() : Content;
		function get categories() : Array;
	}
}
