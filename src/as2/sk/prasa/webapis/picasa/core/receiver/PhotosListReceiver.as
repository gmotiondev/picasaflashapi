import sk.prasa.webapis.picasa.core.utils.Parse;
import sk.prasa.webapis.picasa.core.receiver.AbstractReceiver;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import com.bourre.data.libs.XMLToObjectEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.PhotosListReceiver extends AbstractReceiver implements IReceiver 
{
	public function result(evt : XMLToObjectEvent) : Void
	{
		var tO : Object = evt.getObject();
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_GET_LIST);

		process(tO, tEvt, Parse.photos);
	}
	
	public function fault() : Void
	{
	}
}
