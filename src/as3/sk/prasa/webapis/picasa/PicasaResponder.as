package sk.prasa.webapis.picasa
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	[Event(name="open", type="flash.events.Event")]
	[Event(name="data", type="sk.prasa.webapis.picasa.events.PicasaDataEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="status", type="flash.events.HTTPStatusEvent")]
	
	public class PicasaResponder extends EventDispatcher
	{
		public function PicasaResponder(target : IEventDispatcher = null)
		{
			super(target);
		}
	}
}