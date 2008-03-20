package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.Event;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IReceiver 
	{
		function complete(evt : Event) : void;
	}
}
