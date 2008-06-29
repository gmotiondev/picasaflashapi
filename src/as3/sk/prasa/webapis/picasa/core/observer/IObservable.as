package sk.prasa.webapis.picasa.core.observer 
{
	/**
	 * Observable interface. Part of the Observer Pattern.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public interface IObservable 
	{
		function subscribe(o : IObserver) : void;
		function unsubscribe(o : IObserver) : void
		function notify() : void;
	}
}