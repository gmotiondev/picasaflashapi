package sk.prasa.webapis.picasa.core.observer 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IObservable 
	{
		function subscribe(o : IObserver) : void;
		function unsubscribe(o : IObserver) : void
		function notify() : void;
	}
}