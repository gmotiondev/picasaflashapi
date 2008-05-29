package sk.prasa.webapis.picasa.events
{
	import flash.events.Event;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaEvent extends Event
	{
		public static const OPEN : String = "open";

		public function PicasaEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}