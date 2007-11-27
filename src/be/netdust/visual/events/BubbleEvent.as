 
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;
import be.netdust.visual.events.EventDispatcher;

class be.netdust.visual.events.BubbleEvent 
extends BasicEvent 
{
	public static var ONFOCUS:EventType = new EventType( "onFocus" );
	public static var ONCOMMAND:EventType = new EventType( "onCommand" );
	public static var REGISTERFOCUS:EventType = new EventType( "onRegisterFocus" );	
	
	public function BubbleEvent( e : EventType, oT, _s:EventDispatcher, f:String ) 
	{
		super(e, oT);
		_source=_s;
		_handle = f;
	};
	
	public function getSource() : EventDispatcher
	{
		return _source;
	};
	
	public function getHandle() : String
	{
		return _handle;
	};
	
	public function toString() : String
	{
		return 	PixlibStringifier.stringify( this );
	};
	
	private var _handle:String;
	private var _source:EventDispatcher = null;

}