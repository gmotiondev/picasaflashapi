package sk.prasa.webapis.generic 
{
	import flash.events.HTTPStatusEvent;	
	import flash.events.Event;	
	import flash.net.URLLoader;	
	
	import sk.prasa.webapis.generic.ServiceBase;
	
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	/**
	 *  Dispatched when data is
	 *  received as the download operation progresses.
	 *
	 * 	@eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]

	/**
	 *	Dispatched if a call to the server results in a fatal
	 *	error that terminates the download.
	 *
	 * 	@eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")]

	/**
	 *	A securityError event occurs if a call attempts to
	 *	load data from a server outside the security sandbox.
	 *
	 * 	@eventType flash.events.SecurityErrorEvent.SECURITY_ERROR
	 */
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	
	/**
	 * 
	 */
	[Event(name="open", type="flash.events.Event")]
	/**
	 * 
	 */
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	
	public class PicasaServiceBase extends ServiceBase 
	{	
		public function PicasaServiceBase(target : IEventDispatcher = null)
		{
			super(target);
		}
		
		public function getService() : URLLoader
		{
			var tService : URLLoader = new DynamicXMLService();
				tService.addEventListener(ProgressEvent.PROGRESS, onProgress);
				tService.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				tService.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				tService.addEventListener(Event.OPEN, onOpen);
				tService.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
            
			return tService;
		}
		
		private function onIOError(evt : IOErrorEvent) : void
		{
			dispatchEvent(evt);
		}
		
		private function onSecurityError(evt : SecurityErrorEvent) : void
		{
			dispatchEvent(evt);
		}
		
		private function onProgress(evt : ProgressEvent) : void
		{
			trace("dispatching onProgress");
			dispatchEvent(evt);
		}
		
		private function onOpen(evt : Event) : void
		{
			dispatchEvent(evt);
		}
		
		private function onHttpStatus(evt : HTTPStatusEvent) : void
		{
			dispatchEvent(evt);
		}
	}
}
