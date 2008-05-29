package sk.prasa.webapis.picasa.core
{
	import sk.prasa.webapis.picasa.UrlParams;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	internal class MethodHelper
	{
		private var __params : UrlParams;

		public function MethodHelper()
		{
			__params = new UrlParams();
		}

		public function get params() : UrlParams
		{
			return __params;
		}

		public function set params(p : UrlParams) : void
		{
			__params = p;
		}
	}
}