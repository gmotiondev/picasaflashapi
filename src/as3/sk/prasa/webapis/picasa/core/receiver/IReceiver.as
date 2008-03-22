package sk.prasa.webapis.picasa.core.receiver 
{
	import mx.rpc.events.ResultEvent;	
	import mx.rpc.events.FaultEvent;	
	import mx.rpc.IResponder;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IReceiver
	{
		function result(evt : ResultEvent) : void;
		function fault(evt : FaultEvent) : void;
	}
}
