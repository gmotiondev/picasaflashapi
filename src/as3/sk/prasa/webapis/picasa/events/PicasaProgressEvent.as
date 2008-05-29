package sk.prasa.webapis.picasa.events
{
	import flash.events.ProgressEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaProgressEvent extends ProgressEvent
	{
		public static const PROGRESS : String = "progress";

		public function PicasaProgressEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, bytesLoaded : uint = 0, bytesTotal : uint = 0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}