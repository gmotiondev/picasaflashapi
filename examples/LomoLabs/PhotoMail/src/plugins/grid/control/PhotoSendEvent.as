/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.control.Controller;

class plugins.grid.control.PhotoSendEvent extends BasicPluginEvent
{
	public var from:String;
	public var to:String;
	public var desc:String;
	public var id:String;
	
	public function PhotoSendEvent(owner:IPlugin, aFrom:String, aTo:String, aDesc:String, aId:String)
	{
		super(Controller.PHOTO_SEND_EVENT, owner);
		
		from = aFrom;
		to = aTo;
		desc = aDesc;
		id = aId;
	}
}