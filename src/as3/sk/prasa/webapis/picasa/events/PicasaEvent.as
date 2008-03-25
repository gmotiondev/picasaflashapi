package sk.prasa.webapis.picasa.events 
{
	import sk.prasa.webapis.picasa.PicasaError;
	import sk.prasa.webapis.generic.events.ServiceEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PicasaEvent extends ServiceEvent 
	{
		//public static var AUTH_GET_TOKEN : String = "authGetToken";
	
		public static const ALBUMS_GET_LIST : String = "albumsGetList";
		public static const ALBUMS_GET_LIST_BY_TAG : String = "albumsGetListByTag";
		public static const ALBUMS_GET_SEARCH : String = "albumsGetSearch";
	
		public static const PHOTOS_GET_LIST : String = "photosGetList";
		public static const PHOTOS_GET_LIST_BY_TAG : String = "photosGetListByTag";
		
		public static const TAGS_GET_USER : String = "tagsGetUser";
		public static const TAGS_GET_ALBUM : String = "tagsGetAlbum";
		public static const TAGS_GET_PHOTO : String = "tagsGetPhoto";
		
		public static const COMMENTS_GET_USER : String = "commentsGetUser";
		public static const COMMENTS_GET_ALBUM : String = "commentsGetAlbum";
		public static const COMMENTS_GET_PHOTO : String = "commentsGetPhoto";
		
		public static const COMMUNITY_GET_SEARCH : String = "communityGetSearch";
		
		private var __s : Boolean;
		private var __e : PicasaError;

		public function PicasaEvent(type : String, data : Object = null)
		{
			super(type, data);
		}
		
		public function get success() : Boolean
		{
			return __s;
		}
		
		public function set success(t : Boolean) : void
		{
			__s = t;
		}
		
		public function getSuccess() : Boolean
		{
			return __s;
		}
		
		public function setSuccess(t : Boolean) : void
		{
			__s = t;
		}
		
		public function get error() : PicasaError
		{
			return __e;
		}
		
		public function set error(e : PicasaError) : void
		{
			__e = e;	
		}
		
		public function getError() : PicasaError
		{
			return __e;
		}
		
		public function setError(e : PicasaError) : void
		{
			__e = e;
		}
	}
}
