package sk.prasa.webapis.picasa.core.observer 
{		
	import sk.prasa.webapis.picasa.core.observer.IObservable;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
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

		public function subscribe(o : IObserver) : void
		{
			__observers.push(o);
		}

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

		public function notify() : void
		{
			for(var key : String in __observers)
			{
				IObserver(__observers[key]).update(__o);
			}
		}
		
		public function setObject(o : *) : void
		{
			__o = o;
			
			notify();
		}
	}
}