/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.OpenSearch
{
	public var totalResults : Number;
	public var startIndex : Number;
	public var itemsPerPage : Number;
	
	public function OpenSearch(o : Object)
	{
		totalResults = parseFloat(o["openSearch:totalResults"]);
		startIndex = parseFloat(o["openSearch:startIndex"]);
		itemsPerPage = parseFloat(o["openSearch:itemsPerPage"]);
	}
	
	public function toString() : String
	{
		return "[OpenSearch totalResults=" + totalResults + ", startIndex=" + startIndex + ", itemsPerPage=" + itemsPerPage + "]";
	}
}

/*
<openSearch:totalResults>24759</openSearch:totalResults>
<openSearch:startIndex>1</openSearch:startIndex>
<openSearch:itemsPerPage>192</openSearch:itemsPerPage>  */
