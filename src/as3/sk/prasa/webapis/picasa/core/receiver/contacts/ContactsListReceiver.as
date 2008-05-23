package sk.prasa.webapis.picasa.core.receiver.contacts 
{
	import sk.prasa.webapis.picasa.events.PicasaEvent;	
	
	import flash.net.URLLoader;	
	import flash.events.Event;	
	
	import sk.prasa.webapis.picasa.PicasaService;	
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class ContactsListReceiver extends GetFeedReceiver implements IReceiver
	{
		public function ContactsListReceiver(srv : PicasaService)
		{
			super(srv);
		}
		
		override public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target);
			process(new XML(loader.data), PicasaEvent.CONTACTS_GET_LIST);
		}
	}
}

