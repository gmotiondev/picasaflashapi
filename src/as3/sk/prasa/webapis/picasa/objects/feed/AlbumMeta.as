package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.Meta;
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumMeta extends Meta implements IMeta 
	{
		public function AlbumMeta(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre AlbumEntry
	}
}
