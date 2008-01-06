﻿/**
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
	public static var SET_PHOTOS_EVENT:EventType  	= new EventType("set_photos_event");
	public static var GET_TAGS_EVENT:EventType 		= new EventType("get_tags_event");
	public static var SET_PROGRESS_EVENT:EventType 	= new EventType("set_progress_event");
	public static var SCREEN_RESIZE_EVENT:EventType = new EventType("onResize");
	
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
		push(SET_PHOTOS_EVENT, new SetPhotosCommand());
		push(GET_TAGS_EVENT, new GetTagsCommand());
		push(SCREEN_RESIZE_EVENT, new ScreenResizeCommand());
	}
}