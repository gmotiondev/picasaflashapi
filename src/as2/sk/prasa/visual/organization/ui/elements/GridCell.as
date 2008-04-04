import sk.prasa.visual.organization.ui.elements.Cell;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.elements.GridCell extends Cell 
{
	private var __row : Number;
	private var __column : Number;
	private var __width : Number;
	private var __height : Number;
	
	public function GridCell(c : Number, r : Number, x : Number, y : Number, w : Number, h : Number, link : MovieClip)
	{
		super(x, y, link);
		__row = r;
		__column = c;
		__width = w;
		__height = h;
	}
	
	public function get row() : Number
	{
		return __row;
	}
	
	public function set row(value : Number) : Void
	{
		__row = value;
	}
	
	public function get column() : Number
	{
		return __column;
	}
	
	public function set column(value : Number) : Void
	{
		__column = value;
	}
	
	public function get width() : Number
	{
		return __width;
	}
	
	public function get height() : Number
	{
		return __height;
	}
}
