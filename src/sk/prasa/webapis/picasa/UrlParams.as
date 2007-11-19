/**
 *
 */
class sk.prasa.webapis.picasa.UrlParams
{
	private var __access:String;
	private var __thumbsize:Number;
	private var __imgmax:Number;
	private var __max_results:Number
	private var __start_index:Number
	
	// overwriten
	private var __kind:String;	// !!! default is photo !!!
	private var __tag:String;
	private var __q:String;
	
	// TODO:
	//private var __authkey:String;
	
	public function UrlParams(access:String, thumbsize:Number, imgmax:Number, max_results:Number,start_index:Number)
	{
		__access = access;
		__thumbsize = thumbsize;
		__imgmax = imgmax;
		__max_results = max_results;
		__start_index = start_index;
	}
	
	public function get access():String
	{
		return __access;
	}
	
	public function set access(v:String):Void
	{
		__access = v;
	}
	
	public function get thumbsize():Number
	{
		return __thumbsize;
	}
	
	public function set thumbsize(v:Number):Void
	{
		__thumbsize = v;
	}
	
	public function get imgmax():Number
	{
		return __imgmax;
	}
	
	public function set imgmax(v:Number):Void
	{
		__imgmax = v;
	}
	
	public function get max_results():Number
	{
		return __max_results;
	}
	
	public function set max_results(v:Number):Void
	{
		__max_results = v;
	}
	
	public function get start_index():Number
	{
		return __start_index;
	}
	
	public function set start_index(v:Number):Void
	{
		__start_index = v;
	}
	
	public function get kind():String
	{
		return __kind;
	}
	
	public function set kind(v:String):Void
	{
		__kind = v;
	}
	
	public function get tag():String
	{
		return __tag;
	}
	
	public function set tag(v:String):Void
	{
		__tag = v;
	}
	
	public function get q():String
	{
		return __q;
	}
	
	public function set q(v:String):Void
	{
		__q = v;
	}
	
	public function toString():String
	{
		var tRes = "";
		
		tRes += (kind != null && kind != undefined) ? "?kind="+kind : "photo";
		tRes += (tag != null && tag != undefined) ? "&tag="+tag : "";
		tRes += (q != null && q != undefined) ? "&q="+q : "";
		
		tRes += (access != null && access != undefined) ? "&access="+access : "";
		tRes += (thumbsize != null && thumbsize != undefined) ? "&thumbsize="+thumbsize : "";
		tRes += (imgmax != null && imgmax != undefined) ? "&imgmax="+imgmax : "";
		tRes += (max_results != null && max_results != undefined) ? "&max-results="+max_results : "";
		tRes += (start_index != null && start_index != undefined) ? "&start-index="+start_index : "";
		
		return tRes;
	}
}