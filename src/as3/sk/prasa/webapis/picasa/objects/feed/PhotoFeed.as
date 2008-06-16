package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.Atom;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PhotoFeed extends Atom implements IAtom 
	{
		public function PhotoFeed(xml : XML)
		{
			super(xml);
		}
	}
}
