package command 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IDelegateReceiver 
	{
		function result(data : Array) : void
		function fault(error : Error) : void
	}
}
