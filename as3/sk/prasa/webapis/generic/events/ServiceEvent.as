package sk.prasa.webapis.generic.events 
{
	import flash.events.Event;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ServiceEvent extends Event 
	{	
		private var __o : Object;
		private var __t : String;
		
		public function ServiceEvent(type : String, data : Object = null)
		{
			super(type);
			
			__t = type;
			__o = data;
		}

		public override function get type() : String
		{
			return __t;
		}
		
		public function set type( t : String ) : void
		{
			__t = t;
		}
		
		public function setType( t : String ) : void
		{
			__t = t;
		}

		public function getType() : String
		{
			return __t;
		}

		public function get data() : Object
		{ 
			return __o; 
		}

		public function set data( o : Object ) : void 
		{ 
			__o = o; 
		}
		
		public function setData( o : Object ) : void 
		{ 
			__o = o; 
		}

		public function getData() : Object
		{ 
			return __o; 
		}
	}
}
