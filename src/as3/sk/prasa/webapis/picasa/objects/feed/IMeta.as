package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Title;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public interface IMeta 
	{
		function get title() : Title;
		function get links() : Array;
		//function get subtitle() : SubTitle
		//function get updated() : Date
		//function get id() : String
		//function get authors() : Array
		//function get contributors() : Array
		//function get categories() : Array
		//function get rights() : Rights
		//function get generator() : Generator
		//function get icon() : String
		//function get logo() : String
	}
}
