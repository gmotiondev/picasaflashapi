import sk.prasa.webapis.generic.PicasaServiceBase;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.core.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.PicasaService extends PicasaServiceBase
{	
	private static var __instance : PicasaService;
	
	// properties
	/**
	 * Visibility parameter: all, private, public 
	 */
	public var access : String;
	
	/**
	 * Thumbnail size parameter: 32(c,e),48(c,e),64(c,e),72(e),144(e),160(c,e),200(e),288(e),320(e),400(e),512(e),576(e),640(e),720(e),800(e),912,1024,1152,1280,1440,1600,d 
	 */
	public var thumbsize : Number;
	
	/**
	 * Image size parameter: 32(c,e),48(c,e),64(c,e),72(e),144(e),160(c,e),200(e),288(e),320(e),400(e),512(e),576(e),640(e),720(e),800(e),912,1024,1152,1280,1440,1600,d
	 */
	public var imgmax : Number;
	
	/**
	 * Maximum number of results to be retrieved
	 */
	public var max_results : Number;
	
	/**
	 * 1-based index of the first result to be retrieved
	 */
	public var start_index : Number;
	
	// method bridges
	private var __auth : Auth;
	private var __albums : Albums;
	private var __photos : Photos;
	private var __tags : Tags;
	private var __comments : Comments;
	private var __community : Community;
	
	/**
	 * Singleton pattern
	 * Constructs the new PicasaService service.
	 * Available methods are auth, photos, albums, tags, comments and community.
	 */
	private function PicasaService()
	{	
		System.security.loadPolicyFile(Auth.POLICY_POINT);
		
		__auth = new Auth();
		__photos = new Photos();
		__albums = new Albums();
		__tags = new Tags();
		__comments = new Comments();
		__community = new Community();
	}
	
	/**
	 * Gets instance of PicasaService
	 */
	public static function getInstance() : PicasaService
	{
		if(!__instance) __instance = new PicasaService();
		
		return __instance;
	}

	/**
	 * Bridge to Authentification methods
	 */
	public function get auth() : Auth
	{
		return __auth;
	}

	/**
	 * Bridge to Photos methods
	 */	
	public function get photos() : Photos
	{
		return __photos;
	}
	
	/**
	 * Bridge to Album methods
	 */	
	public function get albums() : Albums
	{
		return __albums;
	}
	
	/**
	 * Bridge to Tags methods
	 */	
	public function get tags() : Tags
	{
		return __tags;
	}
	
	/**
	 * Bridge to Comments methods
	 */	
	public function get comments() : Comments
	{
		return __comments;
	}
	
	/**
	 * Bridge to Community methods
	 */	
	public function get community() : Community
	{
		return __community;
	}
	
	/**
	 * Merges request and service defined parameters
	 * @param request UrlParams VO with url parameters
	 */
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
