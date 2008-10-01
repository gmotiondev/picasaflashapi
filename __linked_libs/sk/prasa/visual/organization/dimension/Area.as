/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code 
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
