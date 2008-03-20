package sk.prasa.webapis.picasa.core.receiver 
{	
	import sk.prasa.webapis.picasa.core.utils.Parse;	
	import sk.prasa.webapis.picasa.core.receiver.AbstractReceiver;
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;
	import sk.prasa.webapis.picasa.events.PicasaResultEvent;
	
	import flash.events.Event;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class AlbumsListByTagReceiver extends AbstractReceiver implements IReceiver 
	{
		public function complete(evt : Event) : void
		{
			var tO : Object = evt.currentTarget;
			var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST_BY_TAG);

			process(tO, tEvt, Parse.photos);
		}
	}
}
