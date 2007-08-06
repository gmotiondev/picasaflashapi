import com.bourre.events.FrontController;
import com.bourre.log.PixlibStringifier;
import com.bourre.core.Model;

import commands.ServiceLoaded;import commands.OnNextPhoto;import commands.OnPrevPhoto;
import commands.OnSetLoaderProgress;

import events.EventList;
import model.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
 
class control.Controller extends FrontController
{
	private static var __instance:Controller;
	
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
		push(EventList.SERVICE_LOADED, new ServiceLoaded());		push(EventList.ON_NEXT_PHOTO, new OnNextPhoto());		push(EventList.ON_PREV_PHOTO, new OnPrevPhoto());
		push(EventList.SET_LOADER_PROGRESS, new OnSetLoaderProgress());
	}
	
	public function pause():Void
	{
		var tModel:ModelApplication = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
			tModel.pause();
	}
	
	public function play():Void
	{
		var tModel:ModelApplication = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
			tModel.play();
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}
