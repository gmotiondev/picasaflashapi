import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier; 
class be.netdust.visual.events.ObserverEvent 
extends BasicEvent 
{
	public static var ObserverEVENT:EventType = new EventType( "onObserver" );
	
	public function ObserverEvent( e : EventType, oT ) 
	{
		super(e, oT);
	};
	
	public function toString() : String
	{
		return 	PixlibStringifier.stringify( this );
	};
}