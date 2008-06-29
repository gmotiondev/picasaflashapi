package sk.prasa.webapis.picasa.objects.feed 
{
	/**
	 * This package also with the <code>sk.prasa.webapis.picasa.objects</code> packaged was inspired by the Adobe syndication lib.
	 * Thank you guys!
	 * 
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
