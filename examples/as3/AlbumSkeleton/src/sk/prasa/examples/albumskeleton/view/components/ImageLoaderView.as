package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ImageLoaderView extends Loader 
	{
		public var id : String;
		public var url : String;
		
		public function ImageLoaderView(aID : String, aURL : String)
		{
			id = aID;
			url = aURL;
			
			this.addEventListener(MouseEvent.CLICK, click);
			
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			this.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error);
			this.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
			
			this.load(new URLRequest(url));
		}
		
		protected function complete(evt : Event) : void
		{
		}
		
		protected function progress(evt : ProgressEvent) : void
		{
		}
		
		protected function error(evt : ErrorEvent) : void
		{
		}
		
		protected function click(evt : MouseEvent) : void
		{
		}
	}
}
