package sk.prasa.webapis.picasa.core.receiver.tags
{	
	import mx.rpc.events.ResultEvent;
	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class TagsUserReceiver extends GetFeedReceiver implements IReceiver 
	{
		override public function result(evt : ResultEvent) : void
		{
			process(evt.result as XML, PicasaEvent.TAGS_GET_USER);
		}
	}
}
