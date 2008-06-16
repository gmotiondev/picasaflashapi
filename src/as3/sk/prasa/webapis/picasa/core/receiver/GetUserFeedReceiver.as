package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.objects.feed.UserFeed;	
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * EXTENDNUT OD GETFEEDRECEIVER A PREPISAT PARSE FUNKCIU
	 * KDE BUDE AKO RETURN TYPE USERFEED A VRATI NEW USERFEED
	 */
	public class GetUserFeedReceiver extends GetFeedReceiver implements IReceiver 
	{
		public function GetUserFeedReceiver()
		{
			super();
		}
		
		override protected function parsefeed(aFeed : XML) : IAtom
		{
			var tUserFeed : IAtom = new UserFeed(aFeed);
			return tUserFeed;
		} 
	}
}
