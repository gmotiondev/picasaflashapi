package sk.prasa.webapis.generic 
{
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ServiceBase extends EventDispatcher 
	{
		public function ServiceBase(target : IEventDispatcher = null)
		{
			super(target);
		}
	}
}
