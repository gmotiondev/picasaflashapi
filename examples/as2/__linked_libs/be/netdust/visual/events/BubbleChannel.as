import com.bourre.events.AbstractEventChannel;
class be.netdust.visual.events.BubbleChannel 
	extends AbstractEventChannel
{
	public static var CHANNEL : String = new BubbleChannel();
	
	private function BubbleChannel() 
	{
		super();
	}
}