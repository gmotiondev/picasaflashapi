/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.InitializeEvent extends BasicPluginEvent
{
	public var photos:Array;
	
	public function InitializeEvent(owner:IPlugin, o:Array)
	{
		super(Controller.INITIALIZE_EVENT, owner);
		
		photos = o;
	}
}