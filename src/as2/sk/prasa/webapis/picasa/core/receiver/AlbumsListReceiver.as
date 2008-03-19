import sk.prasa.webapis.picasa.core.utils.Parse;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import com.bourre.data.libs.XMLToObjectEvent;

import sk.prasa.webapis.picasa.core.receiver.AbstractReceiver;
import sk.prasa.webapis.picasa.core.receiver.IReceiver;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.AlbumsListReceiver extends AbstractReceiver implements IReceiver 
{
	public function result(evt : XMLToObjectEvent) : Void
	{
		var tO : Object = evt.getObject();
		var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_GET_LIST);

		process(tO, tEvt, Parse.albums);
	}
	
	public function fault() : Void
	{
	}
}
