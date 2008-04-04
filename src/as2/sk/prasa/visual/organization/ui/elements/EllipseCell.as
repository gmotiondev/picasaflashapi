import sk.prasa.visual.organization.ui.elements.Cell;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.elements.EllipseCell extends Cell 
{
	private var __rotation:Number = 0;
		
	public function EllipseCell(x : Number, y : Number, rotation : Number, link : MovieClip)
	{
		super(x, y, link);
		__rotation = rotation;
	}
	
	public function get rotation() : Number
	{
		return __rotation;
	}
	
	public function set rotation(value : Number) : Void
	{
		__rotation = value;
	}
}
