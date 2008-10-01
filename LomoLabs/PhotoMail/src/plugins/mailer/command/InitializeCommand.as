/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;

import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.remoting.BasicFaultEvent;
import com.bourre.remoting.BasicResultEvent;
import com.bourre.remoting.IServiceProxyListener;
import com.bourre.remoting.ServiceProxy;
import com.bourre.remoting.ServiceResponder;
import com.bourre.remoting.ServiceMethod;

import plugins.mailer.control.*;
import plugins.mailer.model.*;
import plugins.mailer.business.MailerService;

class plugins.mailer.command.InitializeCommand extends AbstractCommand implements IServiceProxyListener
{
	private var __model:MailerModel;
	private var __lastid:String;
	
	public function execute(evt:InitializeEvent)
	{
		__model = MailerModel(getModelLocator().getModel(ModelList.MAILER_MODEL));
		__lastid = evt.id;
		
		var tService_mailer:ServiceProxy = MailerService.getInstance().getService("Mailer");
			tService_mailer.callServiceMethod(new ServiceMethod("instant_send"),
											  new ServiceResponder(this, onResult, onFault), 
											  evt.from, evt.to, evt.desc, evt.url);
	}
	
	public function onResult(evt:BasicResultEvent):Void 
	{
		trace("Mail send successfully: "+evt.getResult());
		getOwner().firePublicEvent(new BasicEvent(new EventType("onPhotoSent"),{message: "Mail sent successful.", id: __lastid}));
	}
	
	public function onFault(e:BasicFaultEvent):Void 
	{
		trace( "**Error " + this + ".onFault(" + e + ")" );
		getOwner().firePublicEvent(new BasicEvent(new EventType("onPhotoSent"),{message: "Mail sent failed: " + e, id: __lastid}));
	}
}