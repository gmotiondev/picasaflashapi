package sk.prasa.webapis.picasa.core.receiver.comments
{
	import mx.rpc.events.ResultEvent;
	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class CommentsPhotoReceiver extends GetFeedReceiver implements IReceiver 
	{		
		override public function result(evt : ResultEvent) : void
		{
		}
	}
}