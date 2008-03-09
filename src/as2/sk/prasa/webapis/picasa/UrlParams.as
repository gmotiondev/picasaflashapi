/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.UrlParams
{
	public var access : String;
	public var thumbsize : Number;
	public var imgmax : Number;
	public var max_results : Number;
	public var start_index : Number;
	
	// overwriten
	public var kind : String;	// !!! default is photo !!!
	public var tag : String;
	public var q : String;
	public var l : String;
	
	// TODO:
	//public var authkey : String;
	
	public function UrlParams(	aAccess : String,
								aThumbSize : Number,
								aImgmax : Number,
								aMaxResults : Number,
								aStartIndex : Number,
								aKind : String,
								aTag : String,
								aQuery : String,
								aLocation : String)
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
		
		tRes += (kind != null && kind != undefined) ? "?kind=" + kind : "photo";
		tRes += (tag != null && tag != undefined) ? "&tag=" + tag : "";
		tRes += (q != null && q != undefined) ? "&q=" + q : "";
		
		tRes += (access != null && access != undefined) ? "&access=" + access : "";
		tRes += (thumbsize != null && thumbsize != undefined) ? "&thumbsize=" + thumbsize : "";
		tRes += (imgmax != null && imgmax != undefined) ? "&imgmax=" + imgmax : "";
		tRes += (max_results != null && max_results != undefined) ? "&max-results=" + max_results : "";
		tRes += (start_index != null && start_index != undefined) ? "&start-index=" + start_index : "";
		
		return tRes;
	}
}