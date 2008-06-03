package sk.prasa.webapis.picasa 
{
	import sk.prasa.webapis.picasa.objects.UrlParams;
	import flash.system.Security;
	
	import sk.prasa.webapis.picasa.core.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * TODO: check params if it's working correctly!
	 */
	
	final public class PicasaService
	{
		public static var POLICY_FILE_URL : String = "http://photos.googleapis.com/data/crossdomain.xml";  
		public static var FEED_BASE_URL: String = "http://photos.googleapis.com/data/feed/api/";
		
		// methods
		private var __auth : Auth;
		private var __albums : Albums;
		private var __photos : Photos;
		private var __tags : Tags;
		private var __comments : Comments;
		private var __community : Community;

		private var __params : UrlParams;
		
		public function PicasaService()
		{
			Security.loadPolicyFile(PicasaService.POLICY_FILE_URL);

			__params = new UrlParams();
			
			__auth = new Auth();
			__photos = new Photos();
			__albums = new Albums();
			__tags = new Tags();
			__comments = new Comments();
			__community = new Community();
		}
		
		
		public function get access() : String
		{
			return __params.access;
		}
		public function set access(value : String) : void
		{
			// todo
			__params.access = value;
			
			sendParams();
		}
		
		public function get thumbsize() : String
		{
			return __params.thumbsize;
		}
		public function set thumbsize(value : String) : void
		{
			// todo
			__params.thumbsize = value;
			
			sendParams();
		}
		
		public function get imgmax() : String
		{
			return __params.imgmax;
		}
		public function set imgmax(value : String) : void
		{
			// todo
			__params.imgmax = value;
			
			sendParams();
		}
		
		public function get max_results() : Number
		{
			return __params.max_results;
		}
		public function set max_results(value : Number) : void
		{
			// todo
			
			__params.max_results = value;
			
			sendParams();
		}
		
		public function get start_index() : Number
		{
			return __params.start_index;
		}
		public function set start_index(value : Number) : void
		{
			// todo
			__params.start_index = value;
			
			sendParams();
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
		
		private function sendParams() : void
		{
			__auth.params = __params.clone();
			__photos.params = __params.clone();
			__albums.params = __params.clone();
			__tags.params = __params.clone();
			__comments.params = __params.clone();
			__community.params = __params.clone();
		}
	}
}