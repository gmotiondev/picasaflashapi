package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.objects.feed.AlbumFeed;	
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class GetAlbumFeedReceiver extends GetFeedReceiver implements IReceiver 
	{
		public function GetAlbumFeedReceiver()
		{
			super();
		}
		
		override protected function parse(aFeed : XML) : IAtom
		{
			var tAlbumFeed : IAtom = new AlbumFeed(aFeed);
			return tAlbumFeed;
		} 
	}
}
