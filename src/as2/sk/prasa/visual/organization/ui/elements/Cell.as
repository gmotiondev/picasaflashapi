/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.elements.Cell 
{
	private var __link : MovieClip = null;
	private var __x : Number = 0;
	private var __y : Number = 0;
	
	public function Cell(x : Number, y:Number, link : MovieClip)
	{
		__link = link;
		__x = x;
		__y = y;
	}
	
	public function set link(mc : MovieClip) : Void
	{
		__link = mc;
	}
			
	public function get link() : MovieClip
	{
		return __link;
	}
	
	public function set x(value : Number) : Void
	{
		__x = value;
	}
	
	public function get x() : Number
	{
		return __x;
	}
	
	public function set y(value : Number) : Void
	{
		__y = value;
	}
	
	public function get y() : Number
	{
		return __y;
	}
}
