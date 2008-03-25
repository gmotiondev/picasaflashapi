/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.PhotoGetPreviousEvent extends BasicPluginEvent
{
	public function PhotoGetPreviousEvent(owner:IPlugin)
	{
		super(Controller.PHOTO_GET_PREV_EVENT, owner);
	}
}