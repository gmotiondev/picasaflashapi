package sk.prasa.webapis.generic 
{
	import mx.rpc.http.HTTPService;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class DynamicHTTPService extends HTTPService 
	{
		public function DynamicHTTPService(rootURL : String = null)
		{
			super(rootURL);
		}
	}
}
