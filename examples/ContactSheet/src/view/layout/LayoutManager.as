import com.bourre.data.collections.IndexedArray;
import com.bourre.log.PixlibStringifier;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */
/*
	TODO:
	
	UIObject.draw Broadcast when an object is about to draw its graphics.
	UIObject.hide Broadcast when an object's state changes from visible to invisible.
	UIObject.load Broadcast when subobjects are being created.
	UIObject.move Broadcast when the object has moved.
	UIObject.resize Broadcast when an object has been resized.
	UIObject.reveal Broadcast when an object's state changes from invisible to visible.
	UIObject.unload
*/

class view.layout.LayoutManager
{
	private var __items:IndexedArray;
	private var __oEB:EventBroadcaster;
	private var COMPLETE:EventType = new EventType("complete");
	
	public function LayoutManager()
	{
		__items = new IndexedArray();
		__oEB = new EventBroadcaster(this); 
	}
	
	public function addChild(o):Void
	{
		__items.push(o);
	}
	
	public function removeChild(o):Void
	{
		__items.remove(o);
	}
	
	public function getChildren():Array
	{
		return __items;
	}
	
	public function reset():Void
	{
		__items = new IndexedArray();
	}
			
	public function draw():Void
	{	
	}
	
	public function invalidate():Void
	{
	}
	
	public function release() : Void
	{
		_getBroadcaster().removeAllListeners();
	}
	
	public function addListener(oL) : Void
	{
		_getBroadcaster().addListener(oL);
	}
	
	public function removeListener( oL ) : Void
	{
		_getBroadcaster().removeListener( oL );
	}
	
	public function addEventListener( e : EventType, oL, f : Function ) : Void
	{
		_getBroadcaster().addEventListener.apply( _getBroadcaster(), arguments );
	}
	
	public function removeEventListener( e : EventType, oL ) : Void
	{
		_getBroadcaster().removeEventListener( e, oL );
	}
	
	private function _getBroadcaster():EventBroadcaster
	{
		return __oEB;
	}
	
	private function broadcastComplete():Void
	{
		_getBroadcaster().broadcastEvent(new BasicEvent(COMPLETE));
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}