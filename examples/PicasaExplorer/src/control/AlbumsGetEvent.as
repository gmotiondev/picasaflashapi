/**
 *
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.AlbumsGetEvent extends BasicEvent
{
	public var userid:String
	
	public function AlbumsGetEvent(aUserid:String)
	{
		super(Controller.ALBUMS_GET_EVENT);
		trace("AlbumsGetEvent: "+aUserid)
		userid = aUserid;
	}
}