package sk.prasa.webapis.picasa.events
{
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	
	import flash.events.Event;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaDataEvent extends Event
	{
		public static const DATA : String = "data";
		
		//private var __data : Array;
		private var __data : IAtom;

		//public function PicasaDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : Array = null)
		public function PicasaDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : IAtom = null)
		{
			super(type, bubbles, cancelable);
			
			__data = data;
		}

		//public function get data() : Array
		public function get data() : IAtom
		{ 
			return __data; 
		}

		//public function set data(data : Array) : void
		public function set data(data : IAtom) : void 
		{ 
			__data = data; 
		}
	}
}