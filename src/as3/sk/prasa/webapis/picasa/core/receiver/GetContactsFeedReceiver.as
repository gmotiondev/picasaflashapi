package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.objects.feed.UserFeed;	
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class GetContactsFeedReceiver extends GetFeedReceiver implements IReceiver 
	{
		public function GetContactsFeedReceiver()
		{
			super();
		}
		
		override protected function parsefeed(aFeed : XML) : IAtom
		{
			var tContactsFeed : IAtom = new UserFeed(aFeed);
			return tContactsFeed;
		} 
	}
}
