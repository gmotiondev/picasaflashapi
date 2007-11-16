import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var INITIALIZE_EVENT:EventType 	= new EventType("initialize_event");
	public static var PHOTOS_GET_EVENT:EventType  	= new EventType("photos_get_event");
	public static var PROGRESS_SET_EVENT:EventType 	= new EventType("progress_set_event");
	 
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
		push(PHOTOS_GET_EVENT, new PhotosGetCommand());
	}
}
