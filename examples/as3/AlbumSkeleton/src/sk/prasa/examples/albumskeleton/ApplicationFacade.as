package sk.prasa.examples.albumskeleton 
{
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	import sk.prasa.examples.albumskeleton.controller.ErrorCommand;
	import sk.prasa.examples.albumskeleton.controller.LoadCommand;
	import sk.prasa.examples.albumskeleton.controller.StartupCommand;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ApplicationFacade extends Facade 
	{
		public static const STARTUP_EVENT : String = "startup_event";
		public static const LOAD_EVENT : String = "load_event";
		public static const DATA_EVENT : String = "data_event";
		public static const ERROR_EVENT : String = "error_event";
		
		public static const FULLSCREEN_EVENT : String = "fullscreen_event";
		public static const RESIZE_EVENT : String = "resize_event";
		
		public static function getInstance() : ApplicationFacade
		{
			if(instance == null)
			{
				instance = new ApplicationFacade();
			}
			
			return instance as ApplicationFacade;
		}

		override protected function initializeController() : void
		{
			super.initializeController();
			
			this.registerCommand(STARTUP_EVENT, StartupCommand);
			this.registerCommand(LOAD_EVENT, LoadCommand);
			this.registerCommand(ERROR_EVENT, ErrorCommand);
		}

		public function startup(app : DisplayObject) : void
		{
			this.sendNotification(STARTUP_EVENT, app);
		}
	}
}
