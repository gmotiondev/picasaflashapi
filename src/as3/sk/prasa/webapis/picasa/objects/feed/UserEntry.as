package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Utils;	
	import sk.prasa.webapis.picasa.objects.Namespaces;
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.OpenSearch;
	import sk.prasa.webapis.picasa.objects.feed.Entry;
	import sk.prasa.webapis.picasa.objects.feed.IEntry;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class UserEntry extends Entry implements IEntry 
	{
		private var opensearch_ns : Namespace = Namespaces.OPENSEARCH_NS;
		
		public function UserEntry(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre UserEntry
		
		public function get gphoto() : GPhoto
		{
			var tGPhoto : GPhoto = new GPhoto(this.data, Kind.USER);
			return tGPhoto;
		}
		
		public function set gphoto(aGPhoto : GPhoto) : void
		{
			// TODO: ...
		}
		
		public function get opensearch() : OpenSearch
		{
			var tOpenSearch : OpenSearch = new OpenSearch();
				tOpenSearch.totalResults = Utils.parseNumber(this.data.opensearch_ns::totalResults); 
				tOpenSearch.startIndex = Utils.parseNumber(this.data.opensearch_ns::startIndex);
				tOpenSearch.itemsPerPage = Utils.parseNumber(this.data.opensearch_ns::itemsPerPage);
				
			return tOpenSearch;
		}
		
		public function set opensearch(aOpenSearch : OpenSearch) : void
		{
			// TODO: ...
		}
	}
}
