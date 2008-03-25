/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var INITIALIZE_EVENT:EventType 	= new EventType("initialize_event");
	public static var GET_PHOTOS_EVENT:EventType  	= new EventType("get_photos_event");
	public static var SET_PROGRESS_EVENT:EventType 	= new EventType("set_progress_event");
	public static var SCREEN_RESIZE_EVENT:EventType = new EventType("onResize");
	
	public static var GET_NEXT_PAGE_EVENT:EventType = new EventType("get_next_page_event");
	public static var GET_PREV_PAGE_EVENT:EventType = new EventType("get_prev_page_event");
		
	public static var ALERT_EVENT:EventType = new EventType("alert_event");
	
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
		push(GET_PHOTOS_EVENT, new GetPhotosCommand());
		push(SCREEN_RESIZE_EVENT, new ScreenResizeCommand());
		
		push(GET_NEXT_PAGE_EVENT, new GetNextPageCommand());
		push(GET_PREV_PAGE_EVENT, new GetPrevPageCommand());
		
		push(ALERT_EVENT, new AlertCommand());
	}
}