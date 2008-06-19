package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.objects.feed.PhotoFeed;	
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class GetPhotoFeedReceiver extends GetFeedReceiver implements IReceiver 
	{
		public function GetPhotoFeedReceiver()
		{
			super();
		}
		
		override protected function parse(aFeed : XML) : IAtom
		{
			var tPhotoFeed : IAtom = new PhotoFeed(aFeed);
			return tPhotoFeed;
		} 
	}
}
