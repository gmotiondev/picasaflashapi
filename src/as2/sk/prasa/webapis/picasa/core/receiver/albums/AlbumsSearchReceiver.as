import com.bourre.data.libs.XMLToObjectEvent;

import sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;
import sk.prasa.webapis.picasa.events.PicasaEvent;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.albums.AlbumsSearchReceiver extends GetFeedReceiver implements IReceiver 
{
	public function result(evt : XMLToObjectEvent) : Void
	{
		process(evt.getObject(), PicasaEvent.ALBUMS_GET_SEARCH);
	}
}
