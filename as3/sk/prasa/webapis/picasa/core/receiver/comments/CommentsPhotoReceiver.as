package sk.prasa.webapis.picasa.core.receiver.comments
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class CommentsPhotoReceiver extends GetFeedReceiver implements IReceiver 
	{		
		public function CommentsPhotoReceiver(srv : PicasaService)
		{
			super(srv);
		}
		
		override public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target);
		}
	}
}