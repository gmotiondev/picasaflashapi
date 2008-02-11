/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

class plugins.grid.grid extends AbstractPlugin
{
	public function grid()
	{
		super();
	}
	
	private function initialize(aChannelCallback:String, aUser:String, aAlbum:String):Void
	{
		trace("grid up and running! channel-callback: "+aChannelCallback);
		
		var tEvt:IEvent = new BasicEvent(new EventType("getPhotosEvent"), {
			callback:getChannel(),
			user:aUser,
			album:aAlbum
			});

		fireExternalEvent(tEvt,aChannelCallback);
	}
}