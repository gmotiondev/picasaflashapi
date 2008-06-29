package sk.prasa.webapis.picasa
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="open", type="flash.events.Event")]
	[Event(name="data", type="sk.prasa.webapis.picasa.events.PicasaDataEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="status", type="flash.events.HTTPStatusEvent")]
	/**
	 * Picasa responder. Dispatches basic Picasa events.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class PicasaResponder extends EventDispatcher
	{
		/**
		 * PicasaResponder Constructor.
		 * 
		 * Responder is created by main Picasa methods. Each Picasa method returns a PicasaResponder
		 * to listen for basic Picasa events. 
		 * 
		 * @param target IEventDispatcher
		 */
		public function PicasaResponder(target : IEventDispatcher = null)
		{
			super(target);
		}
	}
}