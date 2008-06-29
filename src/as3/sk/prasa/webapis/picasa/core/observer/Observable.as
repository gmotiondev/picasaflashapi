package sk.prasa.webapis.picasa.core.observer 
{		
	import sk.prasa.webapis.picasa.core.observer.IObservable;
	
	/**
	 * Observable. Part of the Observer Pattern.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class Observable implements IObservable 
	{
		private var __o : *;
		private var __observers : Array;

		public function Observable()
		{
			__observers = new Array();
		}

		/**
		 * Subscribes the IObserver instance to the IObservable object
		 * 
		 * @param o IObserver An IObserver instance.
		 */
		public function subscribe(o : IObserver) : void
		{
			__observers.push(o);
		}

		/**
		 * Subscribes the IObserver instance to the IObservable object
		 * 
		 * @param o IObserver An IObserver instance.
		 */
		public function unsubscribe(o : IObserver) : void
		{
			for(var a : int = 0; a < __observers.length; a++)
			{
				if(__observers[a] == o)
				{
					__observers.splice(a, 1);
					break;
				}
			}
		}

		/**
		 * Notify all observers.
		 */
		public function notify() : void
		{
			for(var key : String in __observers)
			{
				IObserver(__observers[key]).update(__o);
			}
		}
		
		/**
		 * Set object to be dispatched.
		 */
		public function setObject(o : *) : void
		{
			__o = o;
			
			notify();
		}
	}
}