/**
 *
 */

class sk.prasa.webapis.picasa.OpenSearch
{
	private var __totalResults:Number;
	private var __startIndex:Number;
	private var __itemsPerPage:Number;
	
	
	public function OpenSearch(o:Object)
	{
		__totalResults = parseFloat(o["openSearch:totalResults"]);
		__startIndex = parseFloat(o["openSearch:startIndex"]);
		__itemsPerPage = parseFloat(o["openSearch:itemsPerPage"]);
	}
	
	public function get totalResults():Number
	{
		return __totalResults;
	}
	
	public function set totalResults(v:Number):Void
	{
		__totalResults = v;
	}

	public function get startIndex():Number
	{
		return __startIndex;
	}
	
	public function set startIndex(v:Number):Void
	{
		__startIndex = v;
	}
	
	public function get itemsPerPage():Number
	{
		return __itemsPerPage;
	}
	
	public function set itemsPerPage(v:Number):Void
	{
		__itemsPerPage = v;
	}
	
	public function toString():String
	{
		return "[OpenSearch totalResults="+totalResults+", startIndex="+startIndex+", itemsPerPage="+itemsPerPage+"]";
	}
}

/*
<openSearch:totalResults>24759</openSearch:totalResults>
<openSearch:startIndex>1</openSearch:startIndex>
<openSearch:itemsPerPage>192</openSearch:itemsPerPage>  */
