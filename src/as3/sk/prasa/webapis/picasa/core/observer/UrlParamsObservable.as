package sk.prasa.webapis.picasa.core.observer 
{
	import sk.prasa.webapis.picasa.core.observer.Observable;
	import sk.prasa.webapis.picasa.core.observer.IObservable;
	
	/**
	 * Makes UrlParams as observable.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class UrlParamsObservable extends Observable implements IObservable 
	{
		public function UrlParamsObservable()
		{
			super();
		}
	}
}