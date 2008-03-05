import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.generic.PicasaServiceBase;
import sk.prasa.webapis.picasa.core.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.PicasaService extends PicasaServiceBase implements IPicasaService
{	
	// unused
	public var api_key : String;
	
	// properties
	public var access : String;
	public var thumbsize : Number;
	public var imgmax : Number;
	public var max_results : Number;
	public var start_index : Number;
	
	// methods
	private var __auth : Auth;
	private var __albums : Albums;
	private var __photos : Photos;
	private var __tags : Tags;
	private var __comments : Comments;
	private var __community : Community;
	
	public function PicasaService(API_KEY : String)
	{	
		//super(this);
		System.security.loadPolicyFile(Auth.POLICY_POINT);
		
		api_key = API_KEY;
		
		__auth = new Auth(this);
		__photos = new Photos(this);
		__albums = new Albums(this);
		__tags = new Tags(this);
		__comments = new Comments(this);
		__community = new Community(this);
	}
	
	
	public function get auth() : Auth
	{
		return __auth;
	}
	
	public function get photos() : Photos
	{
		return __photos;
	}
	
	public function get albums() : Albums
	{
		return __albums;
	}
	
	public function get tags() : Tags
	{
		return __tags;
	}
	
	public function get comments() : Comments
	{
		return __comments;
	}
	
	public function get community() : Community
	{
		return __community;
	}
	
	public function mergeUrlParams(request : UrlParams) : UrlParams
	{
		// request params have priority before service params
		
		var tRes : UrlParams = new UrlParams(
			 access
			,thumbsize
			,imgmax
			,max_results
			,start_index);
			
		if(request.access) tRes.access = request.access;
		
		if(request.thumbsize) tRes.thumbsize = request.thumbsize;
		if(request.imgmax) tRes.imgmax = request.imgmax;
		if(request.max_results) tRes.max_results = request.max_results;
		if(request.start_index) tRes.start_index = request.start_index;
		
		return tRes;
	}
}