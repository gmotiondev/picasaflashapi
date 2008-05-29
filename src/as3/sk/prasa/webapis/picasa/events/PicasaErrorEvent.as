package sk.prasa.webapis.picasa.events
{
	import flash.events.ErrorEvent;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	 
	public class PicasaErrorEvent extends ErrorEvent
	{
		public static const ERROR : String = "error";

		public function PicasaErrorEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, text : String = "Undefined error")
		{
			super(type, bubbles, cancelable, text);
		}
	}
}