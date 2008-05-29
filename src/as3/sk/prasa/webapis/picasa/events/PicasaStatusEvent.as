package sk.prasa.webapis.picasa.events
{
	import flash.events.HTTPStatusEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaStatusEvent extends HTTPStatusEvent
	{
		public static const STATUS : String = "status";

		public function PicasaStatusEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, status : int = 0)
		{
			super(type, bubbles, cancelable, status);
		}
	}
}