/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.ResizeEvent extends BasicPluginEvent
{
	public function ResizeEvent(owner:IPlugin)
	{
		super(Controller.RESIZE_EVENT, owner);
	}
}