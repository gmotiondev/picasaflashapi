package sk.prasa.webapis.generic 
{

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public interface IXMLService 
	{
		function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void;
		function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void;
	}
}
