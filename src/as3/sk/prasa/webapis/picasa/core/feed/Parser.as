package sk.prasa.webapis.picasa.core.feed 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Parser 
	{
		private var __data : XML;
		
		public function Parser(xml : XML)
		{
			data = xml;
		}
		
		protected function get data() : XML
		{
			return __data;
		}
		
		protected function set data(xml : XML) : void
		{
			__data = xml;
		}
	}
}
