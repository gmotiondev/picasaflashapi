import com.bourre.data.libs.XMLToObjectEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

interface sk.prasa.webapis.picasa.core.receiver.IReceiver 
{
	public function result(evt : XMLToObjectEvent) : Void;
	public function fault(evt : XMLToObjectEvent) : Void;
}
