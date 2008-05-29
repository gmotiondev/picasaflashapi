package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class UrlParams 
	{
		public var access : String;
		public var thumbsize : String;
		public var imgmax : String;
		public var max_results : Number;
		public var start_index : Number;
		
		// overriden
		public var kind : String;	// default is photo!
		public var tag : String;
		public var q : String;
		public var l : String;
		public var bbox : String;
		
		public function UrlParams(	aKind : String = "photo",	
									aAccess : String = null,
									aThumbSize : String = null,
									aImgmax : String = null,
									aTag : String = null,
									aQuery : String = null,
									aMaxResults : Number = 100,
									aStartIndex : Number = 1,
									aBbox : String = null,
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
			
			bbox = aBbox;
		}
		
		public function merge(p : UrlParams = null) : UrlParams
		{
			// request params have priority before service params
			if(p != null && p.access != null) access = p.access;
			if(p != null && p.thumbsize != null) thumbsize = p.thumbsize;
			if(p != null && p.imgmax != null) imgmax = p.imgmax;
			if(p != null && !isNaN(p.max_results)) max_results = p.max_results;
			if(p != null && !isNaN(p.start_index)) start_index = p.start_index;
			
			return clone();
		}
		
		public function clone() : UrlParams
		{
			return new UrlParams(kind, access, thumbsize, imgmax, tag, q, max_results, start_index, bbox, l);
		}
		
		public function toString() : String
		{
			var tRes : String = "";
			
			tRes += (kind != null) 			? "?kind=" + kind : "photo";
			tRes += (tag != null) 			? "&tag=" + tag : "";
			tRes += (q != null) 			? "&q=" + q : "";
			tRes += (l != null) 			? "&l=" + l : "";
			
			tRes += (access != null) 		? "&access=" + access : "";
			tRes += (thumbsize != null) 	? "&thumbsize=" + thumbsize : "";
			tRes += (imgmax != null) 		? "&imgmax=" + imgmax : "";
			tRes += (!isNaN(max_results)) 	? "&max-results=" + max_results : "";
			tRes += (!isNaN(start_index)) 	? "&start-index=" + start_index : "";
			tRes += (bbox != null)		 	? "&bbox=" + bbox : "";
			
			return tRes;
		} 
	}
}
