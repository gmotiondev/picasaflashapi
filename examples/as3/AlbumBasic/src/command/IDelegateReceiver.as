package command 
{
	import sk.prasa.webapis.picasa.PicasaError;		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IDelegateReceiver 
	{
		function result(data : Object) : void
		function fault(error : PicasaError) : void
	}
}
