/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.plugin.AbstractPlugin;
import com.bourre.events.IEvent;

import plugins.mailer.control.*;
import plugins.mailer.model.*;

class plugins.mailer.mailer extends AbstractPlugin
{
	public function mailer()
	{
		super();
		
		initialize();
	}
	
	private function initialize():Void
	{
		trace("mailer up and running!");
		
		Controller.getInstance(this).initialize();
		
		var tModel:MailerModel = new MailerModel(this, ModelList.MAILER_MODEL);
	}
	
	public function onSendPhoto(evt:IEvent):Void
	{
		var o:Object = evt.getTarget();
		
		firePrivateEvent(new InitializeEvent(this, o.from, o.to, o.desc, o.url, o.id));
	}
}