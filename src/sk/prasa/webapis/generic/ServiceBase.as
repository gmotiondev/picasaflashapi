import sk.prasa.webapis.generic.IServiceBase;

import com.bourre.events.EventBroadcaster;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.generic.ServiceBase extends EventBroadcaster implements IServiceBase
{
	public function ServiceBase(owner : Object)
	{
		super( owner );
	}
}