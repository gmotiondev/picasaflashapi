package control 
{
	import com.bourre.commands.FrontController;
	
	import command.*;
	import command.photo.*;
	import command.thumb.*;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Controller extends FrontController
	{
		public static const INITIALIZE_EVENT : String 		= "initialize_event";
		public static const RESIZE_EVENT : String 			= "onResize";
		public static const PROGRESS_EVENT : String 		= "onProgress";
		
		public static const PHOTOS_GET_EVENT : String  		= "photos_get_event";
		public static const PHOTO_GET_NEXT_EVENT : String	= "photo_get_next_event";
		public static const PHOTO_GET_PREV_EVENT : String	= "photo_get_prev_event"; 
		public static const PHOTO_CHANGED_EVENT : String	= "photo_changed_event";
		
		public static const THUMB_CLICK_EVENT : String 		= "thumb_click_event";		

		private static var __instance : Controller;
		
		public static function getInstance() : Controller 
		{
			if (__instance == null) __instance = new Controller(new PrivateConstructorAccess());
			
			return __instance;
		} 
		
		public function Controller(access : PrivateConstructorAccess)
		{
			super(null);			
		}
		
		public function initialize() : void
		{
			pushCommandClass(Controller.INITIALIZE_EVENT, InitializeCommand);
			pushCommandClass(Controller.RESIZE_EVENT, ResizeCommand);
			pushCommandClass(Controller.PROGRESS_EVENT, ProgressCommand);
			
			pushCommandClass(Controller.PHOTOS_GET_EVENT, PhotosGetCommand);
			pushCommandClass(Controller.PHOTO_GET_NEXT_EVENT, PhotoGetNextCommand);
			pushCommandClass(Controller.PHOTO_GET_PREV_EVENT, PhotoGetPrevCommand);
		
			pushCommandClass(Controller.THUMB_CLICK_EVENT, ThumbClickCommand);		
		}
	}
}

internal class PrivateConstructorAccess 
{
}
