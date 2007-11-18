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
	
	public static var FAVORITES_ADD:String = "favoritesAdd";
	public static var FAVORITES_GET_LIST:String = "favoritesGetList";
	public static var FAVORITES_GET_PUBLIC_LIST:String = "favoritesGetPublicList";
	public static var FAVORITES_REMOVE:String = "favoritesRemove";
	
	public static var PEOPLE_FIND_BY_EMAIL:String = "peopleFindByEmail";
	public static var PEOPLE_FIND_BY_USERNAME:String = "peopleFindByUsername";
	public static var PEOPLE_GET_INFO:String = "peopleGetInfo";
	public static var PEOPLE_GET_PUBLIC_GROUPS:String = "peopleGetPublicGroups";
	public static var PEOPLE_GET_PUBLIC_PHOTOS:String = "peopleetPublicPhotos";
	public static var PEOPLE_GET_UPLOAD_STATUS:String = "peopleGetUploadStatus";
	
	public static var PHOTOS_ADD_TAGS:String = "photosAddTags";
	public static var PHOTOS_GET_ALL_CONTEXTS:String = "photosGetAllContexts";
	public static var PHOTOS_GET_CONTACTS_PHOTOS:String = "photosGetContactsPhotos";
	public static var PHOTOS_GET_CONTACTS_PUBLIC_PHOTOS:String = "photosGetContactsPublicPhotos";
	public static var PHOTOS_GET_CONTEXT:String = "photosGetContext";
	public static var PHOTOS_GET_COUNTS:String = "photosGetCounts";
	public static var PHOTOS_GET_EXIF:String = "photosGetExif";
	public static var PHOTOS_GET_INFO:String = "photosGetInfo";
	public static var PHOTOS_GET_NOT_IN_SET:String = "photosGetNotInSet";
	public static var PHOTOS_GET_PERMS:String = "photosGetPerms";
	public static var PHOTOS_GET_RECENT:String = "photosGetRecent";
	public static var PHOTOS_GET_SIZES:String = "photosGetSizes";
	public static var PHOTOS_GET_UNTAGGED:String = "photosGetUntagged";
	public static var PHOTOS_REMOVE_TAG:String = "photosRemoveTag";
	public static var PHOTOS_SEARCH:String = "photosSearch";
	public static var PHOTOS_SET_DATES:String = "photosSetDates";
	public static var PHOTOS_SET_META:String = "photosSetMeta";
	public static var PHOTOS_SET_PERMS:String = "photosSetPerms";
	public static var PHOTOS_SET_TAGS:String = "photosSetTags";
	public static var PHOTOS_LICENSES_GET_INFO:String = "photosLicensesGetInfo";
	public static var PHOTOS_LICENSES_SET_LICENSE:String = "photosLicensesSetLicense";
	public static var PHOTOS_NOTES_ADD:String = "photosNotesAdd";
	public static var PHOTOS_NOTES_EDIT:String = "photosNotesEdit";
	public static var PHOTOS_NOTES_DELETE:String = "photosNotesDelete";
	public static var PHOTOS_TRANSFORM_ROTATE:String = "photosTransformRotate";

	public static var PHOTOSETS_ADD_PHOTO:String = "photosetsAddPhoto";
	public static var PHOTOSETS_CREATE:String = "photosetsCreate";
	public static var PHOTOSETS_DELETE:String = "photosetsDelete";
	public static var PHOTOSETS_EDIT_META:String = "photosetsEditMeta";
	public static var PHOTOSETS_EDIT_PHOTOS:String = "photosetsEditPhotos";
	public static var PHOTOSETS_GET_CONTEXT:String = "photosetsGetContext";
	public static var PHOTOSETS_GET_INFO:String = "photosetsGetInfo";
	public static var PHOTOSETS_GET_LIST:String = "photosetsGetList";
	public static var PHOTOSETS_GET_PHOTOS:String = "photosetsGetPhotos";
	public static var PHOTOSETS_ORDER_SETS:String = "photosetsOrderSets";
	public static var PHOTOSETS_REMOVE_PHOTO:String = "photosetsRemovePhoto";

	public static var TAGS_GET_LIST_PHOTO:String = "tagsGetListPhoto";
	public static var TAGS_GET_LIST_USER:String = "tagsGetListUser";
	public static var TAGS_GET_LIST_USER_POPULAR:String = "tagsGetListUserPopular";
	public static var TAGS_GET_RELATED:String = "tagsGetRelated";

	public static var TEST_ECHO:String = "testEcho";
	public static var TEST_LOGIN:String = "testLogin";

	public static var URLS_GET_GROUP:String = "urlsGetGroup";
	public static var URLS_GET_USER_PHOTOS:String = "urlsGetUserPhotos";
	public static var URLS_GET_USER_PROFILE:String = "urlsGetUserProfile";
	public static var URLS_LOOKUP_GROUP:String = "urlsLookupGroup";
	public static var URLS_LOOKUP_USER:String = "urlsLookupUser";
	*/
	
	public static var PHOTOS_LIST:EventType = new EventType("photosList");
	public static var ALBUMS_LIST:EventType = new EventType("albumsList");
	
	public var success:Boolean;
	public var error:PicasaError;

	public function PicasaResultEvent(type:EventType)
	{ 
		super(type);
	}

}