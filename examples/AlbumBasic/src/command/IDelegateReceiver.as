package command 
{
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public interface IDelegateReceiver 
	{
		//function result(data : Array) : void
		function result(data : IAtom) : void
		function fault(error : Error) : void
	}
}
