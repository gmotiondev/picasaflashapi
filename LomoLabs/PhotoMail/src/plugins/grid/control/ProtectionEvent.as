/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.ProtectionEvent extends BasicPluginEvent
{
	public var protect:Boolean = false;
	
	public function ProtectionEvent(owner:IPlugin, aProtect:Boolean)
	{
		super(Controller.PROTECTION_EVENT, owner);
		
		protect = aProtect;
	}
}