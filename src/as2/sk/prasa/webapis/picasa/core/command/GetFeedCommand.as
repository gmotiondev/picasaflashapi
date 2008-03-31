import com.bourre.commands.Delegate;
import com.bourre.data.libs.XMLToObjectEvent;

import sk.prasa.webapis.generic.*;
import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.Auth;
import sk.prasa.webapis.picasa.core.command.ICommand;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.command.GetFeedCommand implements ICommand 
{
	private var service : PicasaService;
	private var receiver : IReceiver;
	private var suffix : String;
	private var params : String;
	
	public function GetFeedCommand(r : IReceiver, s : String, p : String)
	{
		service = PicasaService.getInstance();
		receiver = r;
		suffix = (s != "" && s != "") ? s : "";
		params = p;
	}
	
	public function execute() : Void
	{
		var q : String = "" + suffix + "" + params;
		
		trace("loading: " + Auth.FEEDS_POINT + q);
		
		var l : DynamicXMLService = service.getXMLService();
			l.addEventListener(DynamicXMLService.onLoadInitEVENT, Delegate.create(this, onResult));
			l.addEventListener(DynamicXMLService.onErrorEVENT, Delegate.create(this, onFault));
			l.load(Auth.FEEDS_POINT + q);
	}
	
	private function onResult(evt : XMLToObjectEvent) : Void
	{
		receiver.result(evt);
	}
	
	private function onFault(evt : XMLToObjectEvent) : Void
	{
		receiver.fault(evt);
	}
}
