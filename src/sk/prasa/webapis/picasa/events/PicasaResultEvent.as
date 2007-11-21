/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventType;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.generic.events.ServiceEvent;

class sk.prasa.webapis.picasa.events.PicasaResultEvent extends ServiceEvent
{
	/*
	public static var AUTH_CHECK_TOKEN:String = "authCheckToken";
	public static var AUTH_GET_FROB:String = "authGetFrob";
	public static var AUTH_GET_TOKEN:String = "authGetToken";
	
	public static var TEST_ECHO:String = "testEcho";
	public static var TEST_LOGIN:String = "testLogin";
	*/
	
	public static var ALBUMS_GET_LIST:EventType = new EventType("albumsGetList");
	public static var ALBUMS_GET_LIST_BY_TAG:EventType = new EventType("albumsGetListByTag");
	public static var ALBUMS_GET_SEARCH:EventType = new EventType("albumsGetSearch");

	public static var PHOTOS_GET_LIST:EventType = new EventType("photosGetList");
	public static var PHOTOS_GET_LIST_BY_TAG:EventType = new EventType("photosGetListByTag");
	
	public static var TAGS_GET_USER:EventType = new EventType("tagsGetUser");
	public static var TAGS_GET_ALBUM:EventType = new EventType("tagsGetAlbum");
	public static var TAGS_GET_PHOTO:EventType = new EventType("tagsGetPhoto");
	
	public static var COMMENTS_GET_USER:EventType = new EventType("commentsGetUser");
	public static var COMMENTS_GET_ALBUM:EventType = new EventType("commentsGetAlbum");
	public static var COMMENTS_GET_PHOTO:EventType = new EventType("commentsGetPhoto");
	
	public static var COMMUNITY_GET_SEARCH:EventType = new EventType("communityGetSearch");
	
	public var success:Boolean;
	public var error:PicasaError;

	public function PicasaResultEvent(type:EventType)
	{
		super(type);
	}
}