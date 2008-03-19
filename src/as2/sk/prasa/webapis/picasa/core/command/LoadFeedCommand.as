import sk.prasa.webapis.generic.*;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.Auth;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;
import sk.prasa.webapis.picasa.core.command.ICommand;

import com.bourre.commands.Delegate;
import com.bourre.data.libs.XMLToObjectEvent;


/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.command.LoadFeedCommand implements ICommand 
{
	private var service : IPicasaService;
	private var receiver : IReceiver;
	private var suffix : String;
	private var params : String;
	
	public function LoadFeedCommand(r : IReceiver, s : String, p : UrlParams)
	{
		service = PicasaService.getInstance();
		receiver = r;
		suffix = (s != "" && s != "") ? s : "";
		params = p.toString();
	}
	
	public function execute() : Void
	{		
		var q : String = "" + suffix + "" + params;
		
		trace("loading: " + Auth.FEEDS_POINT + q);
		
		var l : IXMLService = service.getXMLService();
			l.addEventListener(DynamicXMLService.onLoadInitEVENT, Delegate.create(this, onResult));
			l.load(Auth.FEEDS_POINT + q);
	}
	
	private function onResult(evt : XMLToObjectEvent) : Void
	{
		receiver.result(evt);
	}
}
