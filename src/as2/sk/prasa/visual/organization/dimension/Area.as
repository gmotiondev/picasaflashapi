/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.visual.organization.dimension.Area 
{
	public var width : Number;
	public var height : Number;
	private var __area : Number;
	
	public function Area(w : Number, h : Number)
	{
		width = w;
		height = h;
	}
	
	public function get area() : Number
	{
		if(!__area) __area = width * height;
		
		return __area;
	}
}
