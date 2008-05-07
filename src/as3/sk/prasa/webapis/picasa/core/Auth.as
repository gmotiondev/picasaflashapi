package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.PicasaService;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Auth 
	{
		public static var AUTH_POINT : String = "";
		private var service : PicasaService;
		
		public function Auth(srv : PicasaService)
		{
			service = srv;
		}
	}
}
