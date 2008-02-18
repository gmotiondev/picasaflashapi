/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.commands.Delegate;
import com.bourre.events.IEvent;

import plugins.mailer.control.*;

class plugins.mailer.model.MailerModel extends AbstractModel
{	
	public function MailerModel(owner:IPlugin, name:String)
	{
		super(owner, name);
	}
}