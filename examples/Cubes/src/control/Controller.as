/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.FrontController;
 
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
	}
}
