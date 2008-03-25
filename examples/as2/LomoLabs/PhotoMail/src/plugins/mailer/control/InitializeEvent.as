/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.BasicPluginEvent;
import com.bourre.ioc.plugin.IPlugin;

import plugins.mailer.control.Controller;

class plugins.mailer.control.InitializeEvent extends BasicPluginEvent
{	
	public var from:String;
	public var to:String;
	public var desc:String;
	public var url:String
	public var id:String;
	
	public function InitializeEvent(owner:IPlugin, aFrom:String, aTo:String, aDesc:String, aUrl:String, aId:String)
	{
		super(Controller.INITIALIZE_EVENT, owner);
		
		from = aFrom;
		to = aTo;
		desc = aDesc;
		url = aUrl;
		id = aId;
	}
}