/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.dialog.GetSentDialogEvent extends BasicPluginEvent
{	
	public var message:String;
	public var id:String;
	
	public function GetSentDialogEvent(owner:IPlugin, aId:String, aMessage:String)
	{
		super(Controller.GET_SENT_DIALOG_EVENT, owner);
		
		id = aId;
		message = aMessage;
	}
}