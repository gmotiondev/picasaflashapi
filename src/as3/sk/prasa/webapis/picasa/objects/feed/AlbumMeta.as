package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.Meta;
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * TODO: implement AlbumMeta typical methods
	 */
	public class AlbumMeta extends Meta implements IMeta 
	{
		public function AlbumMeta(xmllist : XMLList)
		{
			super(xmllist);
		}
	}
}
