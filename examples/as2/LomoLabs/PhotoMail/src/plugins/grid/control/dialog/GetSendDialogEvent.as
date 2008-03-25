/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.dialog.GetSendDialogEvent extends BasicPluginEvent
{	
	public var id:String;
	
	public function GetSendDialogEvent(owner:IPlugin, aId:String)
	{
		super(Controller.GET_SEND_DIALOG_EVENT, owner);
		
		id = aId;
	}
}