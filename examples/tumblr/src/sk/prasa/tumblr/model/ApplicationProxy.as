package sk.prasa.tumblr.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class ApplicationProxy extends Proxy implements IProxy 
	{	
		public static const NAME : String = "ApplicationProxy";

		public function ApplicationProxy(data : Object = null)
		{
			super(NAME, data);
		}
	}
}
