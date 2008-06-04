package sk.prasa.webapis.picasa 
{
	import flash.system.Security;
	
	import sk.prasa.webapis.picasa.core.*;
	import sk.prasa.webapis.picasa.core.observer.UrlParamsObservable;
	import sk.prasa.webapis.picasa.objects.UrlParams;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	final public class PicasaService
	{
		public static var POLICY_FILE_URL : String = "http://photos.googleapis.com/data/crossdomain.xml";  
		public static var FEED_BASE_URL : String = "http://photos.googleapis.com/data/feed/api/";
		
		private var __auth : Auth;
		private var __albums : Albums;
		private var __photos : Photos;
		private var __tags : Tags;
		private var __comments : Comments;
		private var __community : Community;
		
		private var __params : UrlParams;
		private var __paramsObservable : UrlParamsObservable;

		public function PicasaService()
		{
			Security.loadPolicyFile(PicasaService.POLICY_FILE_URL);

			__params = new UrlParams();
			__paramsObservable = new UrlParamsObservable();
			
			__auth = new Auth();
			__photos = new Photos();
			__albums = new Albums();
			__tags = new Tags();
			__comments = new Comments();
			__community = new Community();
			
			__paramsObservable.subscribe(__auth.params);
			__paramsObservable.subscribe(__photos.params);
			__paramsObservable.subscribe(__albums.params);
			__paramsObservable.subscribe(__tags.params);
			__paramsObservable.subscribe(__comments.params);
			__paramsObservable.subscribe(__community.params);
		}
		
		/**
		 * Returns the access type
		 * @return String
		 */
		public function get access() : String
		{
			return __params.access;
		}
		
		/**
		 * Sets the access type
		 * @param value String "public", "private", "all"
		 */
		public function set access(value : String) : void
		{
			__params.access = value;
			
			sendParams();
		}
		
		/**
		 * Returns thumb size
		 * @return String
		 */
		public function get thumbsize() : String
		{
			return __params.thumbsize;
		}
		
		/**
		 * Sets thumb size
		 * Cropped (c) and Uncropped (u) values: 32, 48, 64, 72, 144, 160 (images are embeddable)
		 * Uncropped (u) values only: 200, 288, 320, 400, 512, 576, 640, 720, 800 (images are embeddable)
		 * Uncropped (u) values only: 912, 1024, 1152, 1280, 1440, 1600 (images are not embeddable)
		 * @param value String Thumb size value, e.g. 72c  
		 */
		public function set thumbsize(value : String) : void
		{
			__params.thumbsize = value;
			
			sendParams();
		}
		
		/**
		 * Returns image max size
		 * @return String
		 */
		public function get imgmax() : String
		{
			return __params.imgmax;
		}
		
		/**
		 * Sets image max size
		 * Cropped (c) and Uncropped (u) values: 32, 48, 64, 72, 144, 160 (images are embeddable)
		 * Uncropped (u) values only: 200, 288, 320, 400, 512, 576, 640, 720, 800 (images are embeddable)
		 * Uncropped (u) values only: 912, 1024, 1152, 1280, 1440, 1600 (images are not embeddable)
		 * @param value String Image max size value, e.g. 72c  
		 */
		public function set imgmax(value : String) : void
		{
			__params.imgmax = value;
			
			sendParams();
		}
		
		/**
		 * Returns maximum number of results to be retrieved
		 * See the Google Data query parameter reference (http://code.google.com/apis/gdata/reference.html#Queries).
		 * @return int
		 */
		public function get max_results() : int
		{
			return __params.max_results;
		}
		
		/**
		 * Sets maximum number of results to be retrieved
		 * See the Google Data query parameter reference (http://code.google.com/apis/gdata/reference.html#Queries).
		 * @param value int Maximum results to be retrieved
		 */
		public function set max_results(value : int) : void
		{
			__params.max_results = value;
			
			sendParams();
		}
		
		/**
		 * Returns 1-based index of the first result to be retrieved
		 * Used to page through the result set. See the Google Data query parameter reference (http://code.google.com/apis/gdata/reference.html#Queries).
		 * @return int
		 */
		public function get start_index() : int
		{
			return __params.start_index;
		}
		
		/**
		 * Sets 1-based index of the first result to be retrieved
		 * Used to page through the result set. See the Google Data query parameter reference (http://code.google.com/apis/gdata/reference.html#Queries).
		 * @param value int Start index of the first results to be retrieved
		 */
		public function set start_index(value : int) : void
		{
			__params.start_index = value;
			
			sendParams();
		}

		/**
		 * Bridge to Authentication methods
		 * TODO: Not implemented yet!
		 */
		public function get auth() : Auth
		{
			return __auth;
		}

		/**
		 * Bridge to Photos methods:
		 * list, list_by_tag, single
		 */	
		public function get photos() : Photos
		{
			return __photos;
		}

		/**
		 * Bridge to Album methods: 
		 * list, list_by_tag, search
		 */	
		public function get albums() : Albums
		{
			return __albums;
		}

		/**
		 * Bridge to Tags methods:
		 * user, album, photo
		 */	
		public function get tags() : Tags
		{
			return __tags;
		}

		/**
		 * Bridge to Comments methods:
		 * user, album, photo
		 */	
		public function get comments() : Comments
		{
			return __comments;
		}

		/**
		 * Bridge to Community methods:
		 * search
		 */	
		public function get community() : Community
		{
			return __community;
		}
		
		/**
		 * Dispatches each param change to the method objects
		 * Used to globaly change the UrlParams
		 */
		private function sendParams() : void
		{
			__paramsObservable.setObject(__params.clone());
		}
	}
}