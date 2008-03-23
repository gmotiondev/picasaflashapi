package sk.prasa.webapis.picasa 
{
	import flash.net.URLLoader;	
	import flash.system.Security;
		
	import sk.prasa.webapis.generic.PicasaServiceBase;
	import sk.prasa.webapis.picasa.picasaservice_internal;
	import sk.prasa.webapis.picasa.core.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PicasaService extends PicasaServiceBase 
	{
		private static var __instance : PicasaService;
		
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

		public function PicasaService(pvt : PicasaServicePrivateClass)
		{
			Security.loadPolicyFile(Auth.POLICY_POINT);

			__auth = new Auth();
			__photos = new Photos();
			__albums = new Albums();
			__tags = new Tags();
			__comments = new Comments();
			__community = new Community();
		}
		
		public static function getInstance() : PicasaService
		{
			if(PicasaService.__instance == null)
			{
				PicasaService.__instance = new PicasaService(new PicasaServicePrivateClass());
			}
			
			return PicasaService.__instance;
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
		public function mergeUrlParams(request : UrlParams = null) : UrlParams
		{
			// request params have priority before service params
			var tRes : UrlParams = new UrlParams(
				 access
				,thumbsize
				,imgmax
				,max_results
				,start_index);
				
			if(request != null && request.access != null) tRes.access = request.access;
			if(request != null && !isNaN(request.thumbsize)) tRes.thumbsize = request.thumbsize;
			if(request != null && !isNaN(request.imgmax)) tRes.imgmax = request.imgmax;
			if(request != null && !isNaN(request.max_results)) tRes.max_results = request.max_results;
			if(request != null && !isNaN(request.start_index)) tRes.start_index = request.start_index;
			
			return tRes;
		}
		
		picasaservice_internal function get service() : URLLoader
		{
			return getService();
		}
	}
}

class PicasaServicePrivateClass
{
	public function PicasaServicePrivateClass(){}
}
