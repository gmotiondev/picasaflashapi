/**
 * @author Michal Gron (michal.gron@gmail.com)
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
