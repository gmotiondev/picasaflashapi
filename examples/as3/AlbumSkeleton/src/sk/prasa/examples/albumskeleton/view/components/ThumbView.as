package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ThumbView extends ImageLoaderView 
	{
		public static const THUMB_CLICK_EVENT : String = "thumb_click_event";
		
		public function ThumbView(aID : String, aURL : String)
		{
			super(aID, aURL);
		}
		
		override protected function complete(evt : Event) : void
		{
			trace("ThumbView.complete");
		}
		
		override protected function progress(evt : ProgressEvent) : void
		{
			trace("ThumbView.progress: " + Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
			// send overall progress notification
		}
		
		override protected function error(evt : ErrorEvent) : void
		{
			trace("ThumbView.error: " + evt.text);
		}
		
		override protected function click(evt : MouseEvent) : void
		{
			dispatchEvent(new Event(THUMB_CLICK_EVENT));
		}
	}
}
