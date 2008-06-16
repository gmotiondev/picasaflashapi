package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Content;
	import sk.prasa.webapis.picasa.objects.Title;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public interface IEntry
	{
		function get title() : Title;
		function get links() : Array;
		function get published() : Date;
		function get authors() : Array;
		//function get contributors() : Array;
		function get content() : Content;
		function get categories() : Array;
		//function get id() : String
		//function get updated() : Date
		//function get summary() : String
	}
}
