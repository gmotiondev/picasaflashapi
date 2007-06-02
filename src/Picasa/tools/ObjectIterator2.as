import com.bourre.data.iterator.ObjectIterator;
import Picasa.tools.MathUtils;

/**
 * @author Michal
 */
class Picasa.tools.ObjectIterator2 extends ObjectIterator
{
	public function ObjectIterator2(o)
	{
		_o = o;
		_a = new Array();
			
		for (var p:String in o) 
		{
			if(typeof(o[p]) != "function") _a.unshift(p);
		}
		
		resetIndex();
	}
	public function setIndex(aI:Number):Void
	{
		_i = aI;
	}
	public function searchKey(aKey:String):Number
	{
		for(var c = 0; c < _a.length; c++)
		{
			if(_o[_a[c]] == aKey) {
				return c;
			}
		}
		return -1;
	}
	
	public function hasPrev():Boolean
	{
		return _i-1 >= 0;
	}
	
	public function prev()
	{
		return _o[ _a[--_i] ];
	}
	
	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	public function seek(n:Number):Void 
	{
		_i = MathUtils.clamp((n-1), -1, _a.length);
	}
}