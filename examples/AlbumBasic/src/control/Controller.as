﻿import com.bourre.events.FrontController;
import com.bourre.events.EventType;

import command.*;
import command.photo.*;
import command.thumb.ThumbClickCommand;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class control.Controller extends FrontController
{
	private static var __instance : Controller;
	
	public static var INITIALIZE_EVENT : EventType 		= new EventType("initialize_event");
	public static var PHOTOS_GET_EVENT : EventType  	= new EventType("photos_get_event");
	public static var PHOTO_GET_NEXT_EVENT : EventType	= new EventType("photo_get_next_event");
	public static var PHOTO_GET_PREV_EVENT : EventType	= new EventType("photo_get_prev_event"); 
	public static var PHOTO_CHANGED_EVENT : EventType	= new EventType("photo_changed_event");
	public static var THUMB_CLICK_EVENT : EventType 	= new EventType("thumb_click_event");
	
	public static var RESIZE_EVENT : EventType 			= new EventType("onResize");
	public static var PROGRESS_EVENT : EventType 		= new EventType("onProgress");
		
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
		push(PHOTO_GET_NEXT_EVENT, new PhotoGetNextCommand());		push(PHOTO_GET_PREV_EVENT, new PhotoGetPrevCommand());
		push(THUMB_CLICK_EVENT, new ThumbClickCommand());
		
		push(RESIZE_EVENT, new ResizeCommand());
		push(PROGRESS_EVENT, new ProgressCommand());
	}
}