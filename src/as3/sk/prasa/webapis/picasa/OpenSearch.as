package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class OpenSearch 
	{
		public var totalResults : Number;
		public var startIndex : Number;
		public var itemsPerPage : Number;
		
		private namespace openSearch = "http://a9.com/-/spec/opensearchrss/1.0/";
		
		public function OpenSearch(item : XML)
		{
			use namespace openSearch;
			
			totalResults = parseFloat(item.totalResults);
			startIndex = parseFloat(item.startIndex);
			itemsPerPage = parseFloat(item.itemsPerPage);
		}
		
		public function toString() : String
		{
			return "[OpenSearch totalResults=" + totalResults + ", startIndex=" + startIndex + ", itemsPerPage=" + itemsPerPage + "]";
		}
	}
}
