package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class UrlParams 
	{
		public var access : String;
		public var thumbsize : Number;
		public var imgmax : Number;
		public var max_results : Number;
		public var start_index : Number;
		
		// overriden
		public var kind : String;	// default is photo!
		public var tag : String;
		public var q : String;
		public var l : String;
				
		public function UrlParams(	aAccess : String,
									aThumbSize : Number,
									aImgmax : Number,
									aMaxResults : Number,
									aStartIndex : Number,
									aKind : String = "photo",
									aTag : String = null,
									aQuery : String = null,
									aLocation : String = null)
		{
			access = aAccess;
			thumbsize = aThumbSize;
			imgmax = aImgmax;
			max_results = aMaxResults;
			start_index = aStartIndex;
			
			kind = aKind;
			tag = aTag;
			q = aQuery;
			l = aLocation;
		}
		
		public function toString() : String
		{
			var tRes : String = "";
			
			tRes += (kind != null) ? "?kind=" + kind : "photo";
			tRes += (tag != null) ? "&tag=" + tag : "";
			tRes += (q != null) ? "&q=" + q : "";
			tRes += (l != null) ? "&l=" + l : "";
			
			tRes += (access != null) ? "&access=" + access : "";
			tRes += (!isNaN(thumbsize )) ? "&thumbsize=" + thumbsize : "";
			tRes += (!isNaN(imgmax)) ? "&imgmax=" + imgmax : "";
			tRes += (!isNaN(max_results)) ? "&max-results=" + max_results : "";
			tRes += (!isNaN(start_index)) ? "&start-index=" + start_index : "";
			
			return tRes;
		} 
	}
}
