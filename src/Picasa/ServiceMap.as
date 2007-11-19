/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;

class Picasa.ServiceMap extends Map2
{
	//private var __map:Map2;
	private var __current:String = null;
	private var __it:ObjectIterator2 = null;
	
	// 
	public function clear():Void
	{
		super.clear();
		__current = null;
		
		reset();
	}
	
	// 
	public function reset():Void
	{
		__it = (size() > 0) ? super.getKeysIterator() : null;
	}
	
	// 
	public function size():Number
	{
		return super.getSize();
	}
	
	// 
	public function contains(aID:String):Boolean
	{
		return super.containsKey(aID);
	}
	
	// 
	public function get current():String
	{
		return __current;
	}
	
	// 
	public function set current(a:String):Void
	{
		__current = a;
	}
	
	// 
	public function get map():ServiceMap
	{
		return this;
	}
	
	// 
	//public function set map(aMap:Map2):Void
	//{
	//	__map = aMap;
	//}
	
	// 
	public function get iterator():ObjectIterator2
	{
		return __it;
	}
	
	// 
	public function set iterator(aIterator:ObjectIterator2):Void
	{
		__it = aIterator;
	}	
}