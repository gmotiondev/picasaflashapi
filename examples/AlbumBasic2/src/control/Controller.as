import com.bourre.events.FrontController;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;
import com.bourre.core.Model;

import command.*;import model.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	public static var INITIALIZE_EVENT:EventType 	= new EventType("initialize_event");
	
	public static var PHOTOS_GET_EVENT:EventType 	= new EventType("photos_get_event");
	 
	public static var RUN_APPLICATION:EventType 	= new EventType("RunApplication");
	public static var SERVICE_LOADED:EventType 		= new EventType("ServiceLoaded");
	public static var PHOTO_CHANGED:EventType 		= new EventType("PhotoChanged");
	public static var PHOTO_CLICK:EventType 		= new EventType("PhotoClick");
	public static var ON_PREV_PHOTO:EventType 		= new EventType("OnPrevPhoto");
	public static var ON_NEXT_PHOTO:EventType 		= new EventType("OnNextPhoto");
	
	public static var SET_LOADER_PROGRESS:EventType = new EventType("OnSetLoaderProgress");
	
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
		push(SERVICE_LOADED, new ServiceLoaded());		push(ON_NEXT_PHOTO, new OnNextPhoto());		push(ON_PREV_PHOTO, new OnPrevPhoto());
		push(SET_LOADER_PROGRESS, new OnSetLoaderProgress());
	}
}
