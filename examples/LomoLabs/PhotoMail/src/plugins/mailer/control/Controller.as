/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.control.PluginController;
import com.bourre.events.EventType;

import plugins.mailer.command.*;

class plugins.mailer.control.Controller
{
	private static var __instance:Controller;
	private var __owner:IPlugin;
	
	public static var INITIALIZE_EVENT:EventType = new EventType("initialize_event");
	
	private function Controller(plugin:IPlugin)
	{
		__owner = plugin;
	}
	
	public static function getInstance(plugin:IPlugin):Controller
	{
		if(!__instance)
		{
			__instance = new Controller(plugin);
		}
		
		return __instance;
	}
	
	public function getController():PluginController
	{
		return __owner.getController();
	}
	
	public function initialize():Void
	{
		getController().pushCommandClass(INITIALIZE_EVENT, InitializeCommand);
	}
}