package sk.prasa.webapis.picasa.events
{
	import flash.events.Event;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaResultEvent extends Event
	{
		public static const COMPLETE : String = "complete";

		private var __data : *;

		public function PicasaResultEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : * = null)
		{
			super(type, bubbles, cancelable);
			
			__data = data;
		}

		public function get data() : *
		{ 
			return __data; 
		}

		public function set data( data : * ) : void 
		{ 
			__data = data; 
		}

		public function setData( data : * ) : void 
		{ 
			__data = data; 
		}

		public function getData() : *
		{ 
			return __data; 
		}
	}
}