import com.bourre.events.FrontController;
import com.bourre.log.PixlibStringifier;

import commands.ServiceLoaded;
import commands.OnNextPhoto;
import commands.OnPrevPhoto;
import commands.OnClosePhoto;
import commands.OnSetLoaderProgress;
import commands.OnResize;
import events.EventList;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
	private function Controller()
	{
		super();
	}

	public static function getInstance() : Controller 
	{
		if (!__instance) {
			__instance = new Controller();
		}
		
		return __instance;
	}
		
	public function initialize() : Void
	{
		push(EventList.SET_LOADER_PROGRESS, new OnSetLoaderProgress());
		push(EventList.SERVICE_LOADED, 		new ServiceLoaded());
		push(EventList.ON_NEXT_PHOTO, 		new OnNextPhoto());
		push(EventList.ON_PREV_PHOTO, 		new OnPrevPhoto());
		push(EventList.ON_CLOSE_PHOTO, 		new OnClosePhoto());
		push(EventList.ON_RESIZE, 			new OnResize());
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}
