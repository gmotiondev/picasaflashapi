import sk.prasa.visual.organization.ui.elements.Cell;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.visual.organization.ui.elements.TileCell extends Cell
{
	private var __width : Number;
	private var __height : Number;
	
	public function TileCell(x : Number, y : Number, w : Number, h : Number, link : MovieClip)
	{
		super(x, y, link);
		
		__width = w;
		__height = h;
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
