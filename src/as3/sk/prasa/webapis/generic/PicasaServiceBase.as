package sk.prasa.webapis.generic 
{
	import flash.events.IOErrorEvent;	
	import flash.events.SecurityErrorEvent;	
	import flash.events.ProgressEvent;	
	
	import sk.prasa.webapis.generic.ServiceBase;
	import sk.prasa.webapis.generic.DynamicXMLService;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PicasaServiceBase extends ServiceBase 
	{
		[Event(name="progress", type="flash.events.ProgressEvent")]
		[Event(name="ioError", type="flash.events.IOErrorEvent")]
		[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
		public function PicasaServiceBase(target : IServiceBase = null)
		{
			super(target);
		}
		
		public function getXMLService() : IXMLService
		{
			var tLoader : IXMLService = new DynamicXMLService();
				tLoader.addEventListener("progress", onProgress);
				tLoader.addEventListener("ioError", onIOError);
				tLoader.addEventListener("securityError", onSecurityError);
				
			return tLoader;
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
			dispatchEvent(evt);
		}
	}
}
