package sk.prasa.webapis.picasa.core.observer 
{
	/**
	 * Observer interface. Part of the Observer Pattern.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public interface IObserver 
	{
		function update(o : *) : void
	}
}