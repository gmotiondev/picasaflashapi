package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.IOErrorEvent;	
	import flash.events.Event;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IReceiver
	{
		function result(evt : Event) : void;
		function fault(evt : IOErrorEvent) : void;
	}
}
