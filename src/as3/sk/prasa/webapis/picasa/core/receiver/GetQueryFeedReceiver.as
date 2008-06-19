package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.objects.feed.QueryFeed;	
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class GetQueryFeedReceiver extends GetFeedReceiver implements IReceiver 
	{
		public function GetQueryFeedReceiver()
		{
			super();
		}
		
		override protected function parse(aFeed : XML) : IAtom
		{
			var tQueryFeed : IAtom = new QueryFeed(aFeed);
			return tQueryFeed;
		} 
	}
}
