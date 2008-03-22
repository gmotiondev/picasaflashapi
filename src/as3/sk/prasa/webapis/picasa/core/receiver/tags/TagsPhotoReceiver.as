package sk.prasa.webapis.picasa.core.receiver.tags
{
	import mx.rpc.events.ResultEvent;
	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaResultEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class TagsPhotoReceiver extends GetFeedReceiver implements IReceiver 
	{
		override public function result(evt : ResultEvent) : void
		{
			process(evt.result as XML, PicasaResultEvent.TAGS_GET_PHOTO);
		}
	}
}
