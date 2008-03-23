package sk.prasa.webapis.picasa.core.receiver.photos
{
	import flash.net.URLLoader;
	import flash.events.Event;
	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosListByTagReceiver extends GetFeedReceiver implements IReceiver 
	{
		override public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target);
			process(new XML(loader.data), PicasaEvent.PHOTOS_GET_LIST_BY_TAG);
		}
	}
}
