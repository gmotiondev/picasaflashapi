package sk.prasa.webapis.generic 
{	
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.generic.IXMLService;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class DynamicXMLService extends URLLoader implements IXMLService 
	{
		public function DynamicXMLService()
		{
			super();
		}
	}
}
