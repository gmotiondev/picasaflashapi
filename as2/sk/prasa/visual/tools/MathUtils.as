/**
 * Deprecated, will be deleted
 */
 class sk.prasa.visual.tools.MathUtils
{
	/**
	 * Taken from vegas project.
	 * Bounds a numeric value between 2 numbers.
	 * @param value the value to clamp.
	 * @param min the min value of the range.
	 * @param max the max value of the range.
	 * @return a bound numeric value between 2 numbers.
	 */
	static public function clamp(value:Number, min:Number, max:Number):Number 
	{
		if (isNaN(value)) 
		{
			trace("MathsUtils.clamp, argument 'value' must not be 'null' or 'undefined' or 'NaN'");
		}
		if (isNaN(min)) 
		{
			min = value;
		}
		if (isNaN(max)) 
		{
			max = value;
		}
		return Math.max(Math.min(value, max), min);
	}
	/**
	 * 
	 */
	public static function convertCoords(p:Object, f:MovieClip, t:MovieClip):Object
	{
		if (!f || !t) {
			return p;
		}
		
		f.localToGlobal(p);
		t.globalToLocal(p);
		
		return p;
	}
	/**
	 * 
	 */
	public static function convertDistance(d:Object, f:MovieClip, t:MovieClip):Object
	{
		var tTL = {x:0, y:0};
		
		if (!f || !t) {
			return null;	
		}

		MathUtils.convertCoords(tTL, f, t);
		MathUtils.convertCoords(d, f, t);
		d.x -= tTL.x;
		d.y -= tTL.y;
		
		return d;
	}
	
	public static function addRange(aArray:Array,aStartIndex:Number,aEndIndex:Number,aOffset:Number):Number
	{
		var tRes:Number = 0;
		
		for(var a = aStartIndex; a < aEndIndex; a++) {
			tRes += aArray[a]+aOffset;
		}
		
		return tRes;
	}
	
	public static function getRangeMax(aArray:Array,aStartIndex:Number,aEndIndex:Number):Number
	{
		var tRes:Number = 0;
		
		for(var a = aStartIndex; a < aEndIndex; a++) {
			tRes = Math.max(tRes,aArray[a]);
		}
		
		return tRes;
	}
}