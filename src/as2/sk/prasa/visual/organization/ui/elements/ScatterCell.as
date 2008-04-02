import sk.prasa.visual.organization.ui.elements.Cell;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.visual.organization.ui.elements.ScatterCell extends Cell 
{
	private var __rotation : Number = 0;
		
	public function ScatterCell(x : Number, y : Number, r : Number, link : MovieClip)
	{
		super(x, y, link);
		__rotation = r;
	}
	
	public function get rotation() : Number
	{
		return __rotation;
	}
	
	public function set rotation(value : Number) : Void
	{
		__rotation=value;
	}	
}
