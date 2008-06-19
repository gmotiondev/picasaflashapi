package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Geo;
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.Media;
	import sk.prasa.webapis.picasa.objects.Namespaces;
	import sk.prasa.webapis.picasa.objects.OpenSearch;
	import sk.prasa.webapis.picasa.objects.Utils;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumEntry extends Entry implements IEntry 
	{
		private var georss_ns : Namespace = Namespaces.GEORSS_NS;
		private var gml_ns : Namespace = Namespaces.GML_NS;
		private var opensearch_ns : Namespace = Namespaces.OPENSEARCH_NS;
		
		public function AlbumEntry(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre AlbumEntry
		
		public function get gphoto() : GPhoto
		{
			var tGPhoto : GPhoto = new GPhoto(this.data, Kind.ALBUM);
			return tGPhoto;
		}
		
		public function set gphoto(aGPhoto : GPhoto) : void
		{
			// TODO: ...
		}
		
		public function get media() : Media
		{
			var tMedia : Media = new Media(this.data);
			return tMedia;
		}
		
		public function set media(aMedia : Media) : void
		{
			// TODO: ...
		}
		
		public function get geo() : Geo
		{
			// rewrite this.. if georss_ns is null ... 
			
			var tGeo : Geo = new Geo();
			
			try
			{
				var tGeoArray : Array = this.data.georss_ns::where.gml_ns::Point.gml_ns::pos.split(" ");
				
				tGeo.latitude = tGeoArray[0];
				tGeo.longitude = tGeoArray[1];
				
			} catch(e : Error)
			{
				//if album/photo doesn't contains any geo info
			}
			
			return tGeo;
		}
		
		public function set get(aGeo : Geo) : void
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
