import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;
import command.thumb.LoadThumbsCommand;
import command.page.GetNextPageCommand;
import command.page.GetPrevPageCommand;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var LOAD_THUMBS_EVENT : EventType 	= new EventType("load_thumbs_event");
	public static var LOAD_FEED_EVENT : EventType  		= new EventType("get_photos_event");
	public static var PROGRESS_EVENT : EventType 		= new EventType("onProgress");
	public static var RESIZE_EVENT : EventType 			= new EventType("onResize");
	
	public static var GET_NEXT_PAGE_EVENT : EventType 	= new EventType("get_next_page_event");
	public static var GET_PREV_PAGE_EVENT : EventType 	= new EventType("get_prev_page_event");

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
		push(LOAD_THUMBS_EVENT, new LoadThumbsCommand());
		push(LOAD_FEED_EVENT, new LoadFeedCommand());
		push(RESIZE_EVENT, new ResizeCommand());
		push(PROGRESS_EVENT, new ProgressCommand());
		
		push(GET_NEXT_PAGE_EVENT, new GetNextPageCommand());
		push(GET_PREV_PAGE_EVENT, new GetPrevPageCommand());
	}
}