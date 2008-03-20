package sk.prasa.webapis.picasa 
{
	import sk.prasa.webapis.generic.IPicasaService;	
	
	import flash.system.Security;		
		
	import sk.prasa.webapis.generic.PicasaServiceBase;
	import sk.prasa.webapis.generic.IXMLService;
	
	import sk.prasa.webapis.picasa.core.*;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PicasaService extends PicasaServiceBase implements IPicasaService 
	{
		private static var __instance : PicasaService;
		
		// unused
		public var api_key : String;
		
		// namespace
		public namespace picasaservice_internal = "http://www.prasa.sk/webapis/picasa/internal"; 
		
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

		private function PicasaService()
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

		picasaservice_internal function getXMLService() : IXMLService
		{
			return getXMLService();
		}
	}
}
