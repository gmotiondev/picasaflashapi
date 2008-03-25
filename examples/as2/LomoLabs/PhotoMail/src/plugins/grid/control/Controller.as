/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.control.PluginController;
import com.bourre.events.EventType;

import plugins.grid.command.*;
import plugins.grid.command.dialog.*;

class plugins.grid.control.Controller
{
	private static var __instance:Controller;
	private var __owner:IPlugin;
	
	public static var INITIALIZE_EVENT:EventType = new EventType("initialize_event");
	public static var SHOW_PHOTOS_EVENT:EventType = new EventType("show_photos_event");
	
	public static var PHOTO_GET_NEXT_EVENT:EventType= new EventType("photo_get_next_event");
	public static var PHOTO_GET_PREV_EVENT:EventType= new EventType("photo_get_prev_event");
	public static var PHOTO_SEND_EVENT:EventType= new EventType("photo_send_event");
	public static var PHOTO_CLICK_EVENT:EventType 	= new EventType("photo_click_event"); 
	public static var PHOTO_CHANGED_EVENT:EventType	= new EventType("photo_changed_event");
	public static var PHOTO_CLOSED_EVENT:EventType	= new EventType("photo_closed_event");
	//public static var PHOTO_SET_TITLE_EVENT:EventType=new EventType("photo_set_title_event");
	public static var RESIZE_EVENT:EventType = new EventType("resize_event");
	public static var PROTECTION_EVENT:EventType = new EventType("protection_event");
	
	public static var GET_SEND_DIALOG_EVENT:EventType = new EventType("get_send_dialog_event");
	public static var GET_SENDING_DIALOG_EVENT:EventType = new EventType("get_sending_dialog_event");
	public static var GET_SENT_DIALOG_EVENT:EventType = new EventType("get_sent_dialog_event");
	
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
		getController().pushCommandClass(SHOW_PHOTOS_EVENT, ShowPhotosCommand);
		getController().pushCommandClass(PHOTO_CLICK_EVENT, PhotoClickCommand);
		getController().pushCommandClass(PHOTO_CLOSED_EVENT, PhotoClosedCommand);
		
		getController().pushCommandClass(PHOTO_GET_NEXT_EVENT, PhotoGetNextCommand);
		getController().pushCommandClass(PHOTO_GET_PREV_EVENT, PhotoGetPrevCommand);
		getController().pushCommandClass(PHOTO_SEND_EVENT, PhotoSendCommand);
		
		getController().pushCommandClass(RESIZE_EVENT, ResizeCommand);
		getController().pushCommandClass(PROTECTION_EVENT, ProtectionCommand);
		
		getController().pushCommandClass(GET_SENDING_DIALOG_EVENT, GetSendingDialogCommand);
		getController().pushCommandClass(GET_SEND_DIALOG_EVENT, GetSendDialogCommand);
		getController().pushCommandClass(GET_SENT_DIALOG_EVENT, GetSentDialogCommand);
	}
}