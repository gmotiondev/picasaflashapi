package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import sk.prasa.examples.albumskeleton.view.components.ImageLoaderView;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PhotoView extends ImageLoaderView 
	{
		public static const PHOTO_CLICK_EVENT : String = "photo_click_event";
		
		public function PhotoView(aID : String, aURL : String)
		{
			super(aID, aURL);
		}
		
		override protected function complete(evt : Event) : void
		{
			trace("PhotoView.complete");
		}
		
		override protected function progress(evt : ProgressEvent) : void
		{
			trace("PhotoView.progress: " + Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
			// send overall progress notification
		}
		
		override protected function error(evt : ErrorEvent) : void
		{
			trace("PhotoView.error: " + evt.text);
		}
		
		override protected function click(evt : MouseEvent) : void
		{
			dispatchEvent(new Event(PHOTO_CLICK_EVENT));
		}
	}
}
