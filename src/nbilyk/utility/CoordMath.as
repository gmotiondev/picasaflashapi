class nbilyk.utility.CoordMath
{
	/**
	 * 	 */
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
	 * 	 */
	public static function convertDistance(d:Object, f:MovieClip, t:MovieClip):Object
	{
		var tTL = {x:0, y:0};
		
		if (!f || !t) {
			return null;	
		}

		CoordMath.convertCoords(tTL, f, t);
		CoordMath.convertCoords(d, f, t);
		d.x -= tTL.x;
		d.y -= tTL.y;
		
		return d;
	}
}