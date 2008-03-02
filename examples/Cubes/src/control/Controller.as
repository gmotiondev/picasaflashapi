import com.bourre.events.EventType;
import com.bourre.events.FrontController;

import command.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.Controller extends FrontController
{
	private static var __instance:Controller;

	public static var INITIALIZE_ALBUMS_EVENT : EventType = new EventType("initialize_albums_event");
	public static var INITIALIZE_PHOTOS_EVENT : EventType = new EventType("initialize_photos_event");
	public static var INITIALIZE_PHOTO_EVENT : EventType = new EventType("initialize_photo_event");
	
	public static var SET_ALBUMS_THUMB_EVENT : EventType = new EventType("set_albums_thumb_event");
	public static var SET_PHOTOS_THUMB_EVENT : EventType = new EventType("set_photos_thumb_event");

	public static var ALBUM_OPEN_EVENT : EventType = new EventType("album_open_event");
	public static var ALBUM_CLOSE_EVENT : EventType = new EventType("album_close_event");

	public static var PHOTO_OPEN_EVENT : EventType = new EventType("photo_open_event");
	public static var PHOTO_CLOSE_EVENT : EventType = new EventType("photo_close_event");

	public static var CHANGE_CAMERA_EXTRA_EVENT : EventType = new EventType("change_camera_extra_event");
	public static var CHANGE_THUMB_EXTRA_EVENT : EventType = new EventType("change_thumb_extra_event");
	
	public static var RESIZE_EVENT : EventType = new EventType("onResize");
	public static var PROGRESS_EVENT : EventType = new EventType("onProgress");

	public static function getInstance() : Controller 
	{
		if (!__instance) {
			__instance = new Controller();
		}
		
		return __instance;
	}
	
	private function Controller()
	{
		super();
	}
	
	public function initialize() : Void
	{
		push(INITIALIZE_ALBUMS_EVENT, new InitializeAlbumsCommand());
		push(INITIALIZE_PHOTOS_EVENT, new InitializePhotosCommand());
		push(INITIALIZE_PHOTO_EVENT, new InitializePhotoCommand());
		
		push(SET_ALBUMS_THUMB_EVENT, new SetAlbumsThumbCommand());
		push(SET_PHOTOS_THUMB_EVENT, new SetPhotosThumbCommand());
		
		push(ALBUM_OPEN_EVENT, new AlbumOpenCommand());
		push(ALBUM_CLOSE_EVENT, new AlbumCloseCommand());

		push(PHOTO_OPEN_EVENT, new PhotoOpenCommand());
		push(PHOTO_CLOSE_EVENT, new PhotoCloseCommand());
		
		push(CHANGE_CAMERA_EXTRA_EVENT, new ChangeCameraExtraCommand());
		push(CHANGE_THUMB_EXTRA_EVENT, new ChangeThumbExtraCommand());
		
		push(RESIZE_EVENT, new ResizeCommand());
	}
}
