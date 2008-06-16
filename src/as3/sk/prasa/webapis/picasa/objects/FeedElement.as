package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class FeedElement 
	{
		private var __data : XMLList;

		public function FeedElement(xmllist : XMLList)
		{
			data = xmllist;
		}

		protected function get data() : XMLList
		{
			return __data;
		}

		protected function set data(xmllist : XMLList) : void
		{
			__data = xmllist;
		}
	}
}
