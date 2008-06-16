package sk.prasa.webapis.picasa.objects
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class OpenSearch
	{
		public var totalResults : int;
		public var startIndex : int;
		public var itemsPerPage : int;

		public function OpenSearch(aTotalResults : int = 0, aStartIndex : int = 0, aItemsPerPage : int = 0)
		{	
			totalResults = aTotalResults;
			startIndex = aStartIndex;
			itemsPerPage = aItemsPerPage;
		}

		public function toString() : String
		{
			return "[OpenSearch " + " totalResults=" + totalResults + ", startIndex=" + startIndex + ", itemsPerPage=" + itemsPerPage + "]";
		} 
	}
}
