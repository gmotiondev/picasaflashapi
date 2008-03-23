package sk.prasa.webapis.picasa.core.receiver.photos
{
	import mx.rpc.events.ResultEvent;
	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosListReceiver extends GetFeedReceiver implements IReceiver 
	{
		override public function result(evt : ResultEvent) : void
		{
			process(evt.result as XML, PicasaEvent.PHOTOS_GET_LIST);
		}
	}
}
