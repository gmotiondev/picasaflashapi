/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.ShowPhotosEvent extends BasicPluginEvent
{
	public function ShowPhotosEvent(owner:IPlugin)
	{
		super(Controller.SHOW_PHOTOS_EVENT, owner);
	}
}