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
		public function ThumbView(aID : String, aURL : String)
		{
			super(aID, aURL);
		}
		
		override protected function complete(evt : Event) : void
		{
			evt.stopImmediatePropagation();
			dispatchEvent(evt);
		}
		
		override protected function progress(evt : ProgressEvent) : void
		{
			evt.stopImmediatePropagation();
			dispatchEvent(evt);
		}
		
		override protected function error(evt : ErrorEvent) : void
		{
			trace("ThumbView.error: " + evt.text);
		}
		
		override protected function click(evt : MouseEvent) : void
		{
		}
	}
}
