/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var INITIALIZE_EVENT:EventType = new EventType("initialize_event");
	public static var PROGRESS_EVENT:EventType = new EventType("progress_event");
	public static var RESIZE_EVENT:EventType = new EventType("resize_event");
	public static var GET_NEXT_PHOTO_EVENT:EventType = new EventType("get_next_photo_event");
	public static var GET_PREV_PHOTO_EVENT:EventType = new EventType("get_prev_photo_event");
	public static var PHOTO_CHANGED_EVENT:EventType = new EventType("photo_changed_event");
	
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
		push(INITIALIZE_EVENT, new InitializeCommand());
		push(RESIZE_EVENT, new ResizeCommand());
		push(GET_NEXT_PHOTO_EVENT, new GetNextPhotoCommand());
		push(GET_PREV_PHOTO_EVENT, new GetPrevPhotoCommand());
	}
}