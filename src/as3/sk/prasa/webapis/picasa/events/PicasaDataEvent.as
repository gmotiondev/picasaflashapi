package sk.prasa.webapis.picasa.events
{
	import flash.events.Event;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaDataEvent extends Event
	{
		public static const DATA : String = "data";
		
		private var __data : Array;

		public function PicasaDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : Array = null)
		{
			super(type, bubbles, cancelable);
			
			__data = data;
		}

		public function get data() : Array
		{ 
			return __data; 
		}

		public function set data(data : Array) : void 
		{ 
			__data = data; 
		}
	}
}