/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;

class Picasa.ServiceMap
{
	private var __map:Map2;
	private var __current:String = null;
	private var __it:ObjectIterator2 = null;
	
	// 
	private function clear():Void
	{
		__map.clear();
		__current = null;
		
		reset();
	}
	
	// 
	private function reset():Void
	{
		__it = (size() > 0) ? __map.getKeysIterator() : null;
	}
	
	// 
	private function size():Number
	{
		return __map.getSize();
	}
	
	// 
	private function contains(aID:String):Boolean
	{
		return __map.containsKey(aID);
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
	public function get map():Map2
	{
		return __map;
	}
	
	// 
	public function set map(aMap:Map2):Void
	{
		__map = aMap;
	}
	
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