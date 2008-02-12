/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;

import plugins.grid.control.Controller;

class plugins.grid.control.ShowPhotosEvent extends BasicEvent
{
	public var photos:Array;
	
	public function ShowPhotosEvent(o:Array)
	{
		super(Controller.SHOW_PHOTOS_EVENT);
		
		photos = o;
	}
}