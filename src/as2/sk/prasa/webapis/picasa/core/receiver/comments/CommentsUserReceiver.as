import com.bourre.data.libs.XMLToObjectEvent;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;
import sk.prasa.webapis.picasa.events.PicasaEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.comments.CommentsUserReceiver extends GetFeedReceiver implements IReceiver 
{
	public function CommentsUserReceiver(srv : PicasaService)
	{
		super(srv);
	}
	
	public function result(evt : XMLToObjectEvent) : Void
	{
		process(evt.getObject(), PicasaEvent.COMMENTS_GET_USER);
	}
}
