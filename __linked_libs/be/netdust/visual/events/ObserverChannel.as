import com.bourre.events.AbstractEventChannel;
class be.netdust.visual.events.ObserverChannel 
	extends AbstractEventChannel
{
	public static var CHANNEL : String = new ObserverChannel();
	
	private function ObserverChannel() 
	{
		super();
	}
}