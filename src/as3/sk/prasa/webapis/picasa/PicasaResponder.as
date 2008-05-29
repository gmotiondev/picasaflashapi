package sk.prasa.webapis.picasa
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[Event(name="open", type="sk.prasa.webapis.picasa.events.PicasaEvent")]
	[Event(name="complete", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	[Event(name="progress", type="sk.prasa.webapis.picasa.events.PicasaProgressEvent")]
	[Event(name="error", type="sk.prasa.webapis.picasa.events.PicasaErrorEvent")]
	[Event(name="status", type="sk.prasa.webapis.picasa.events.PicasaStatusEvent")]
	
	public class PicasaResponder extends EventDispatcher
	{
		public function PicasaResponder(target : IEventDispatcher = null)
		{
			super(target);
		}
	}
}