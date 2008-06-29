package sk.prasa.webapis.picasa.events
{
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	
	import flash.events.Event;	

	/**
	 * Event constructed when the feed data is successfuly downloaded and parsed
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 */
	public class PicasaDataEvent extends Event
	{
		/**
		 * On DATA Event type. 
		 */
		public static const DATA : String = "data";
		
		private var __data : IAtom;

		/**
		 * Picasa data event constructor.
		 * 
		 * @param type String
		 * @param bubbles Boolean
		 * @param cancelable Boolean
		 * @param data IAtom
		 */
		public function PicasaDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : IAtom = null)
		{
			super(type, bubbles, cancelable);
			
			__data = data;
		}
		
		/**
		 * The data property. Contains IAtom feed. 
		 */
		public function get data() : IAtom
		{ 
			return __data; 
		}
		
		/**
		 * @private
		 */
		public function set data(data : IAtom) : void 
		{ 
			__data = data; 
		}
	}
}