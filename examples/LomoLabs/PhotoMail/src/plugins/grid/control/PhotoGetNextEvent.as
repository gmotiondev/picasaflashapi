/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.PhotoGetNextEvent extends BasicPluginEvent
{
	public function PhotoGetNextEvent(owner:IPlugin)
	{
		super(Controller.PHOTO_GET_NEXT_EVENT, owner);
	}
}