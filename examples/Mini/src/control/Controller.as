import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var GET_ALBUM_EVENT : EventType = new EventType("get_album_event");
	public static var LOAD_THUMBS_EVENT : EventType = new EventType("load_thumbs_event");
	 
	public static var PHOTO_GET_NEXT_EVENT : EventType = new EventType("photo_get_next_event");
	public static var PHOTO_GET_PREV_EVENT : EventType = new EventType("photo_get_prev_event");
	public static var PHOTO_CLICK_EVENT : EventType = new EventType("photo_click_event"); 
	public static var PHOTO_CHANGED_EVENT : EventType = new EventType("photo_changed_event");
	
	public static var PROGRESS_EVENT : EventType = new EventType("progress_event");
	
	public static function getInstance() : Controller 
	{
		if (!__instance) __instance = new Controller();
				
		return __instance;
	}
	
	private function Controller()
	{
		super();
	}
	
	public function initialize() : Void
	{
		push(GET_ALBUM_EVENT, new GetAlbumCommand());
		push(LOAD_THUMBS_EVENT, new LoadThumbsCommand());
		
		push(PHOTO_GET_NEXT_EVENT, new PhotoGetNextCommand());
		push(PHOTO_GET_PREV_EVENT, new PhotoGetPrevCommand());
		push(PHOTO_CLICK_EVENT, new PhotoClickCommand());
		
		push(PROGRESS_EVENT, new ProgressCommand());
	}
}