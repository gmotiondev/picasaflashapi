class Picasa.tools.MathUtils
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
}