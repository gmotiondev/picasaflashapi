package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.Atom;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class QueryFeed extends Atom implements IAtom 
	{
		public function QueryFeed(xml : XML)
		{
			super(xml);
		}
	}
}
