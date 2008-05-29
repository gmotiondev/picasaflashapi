import sk.prasa.visual.organization.ui.elements.Cell;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.elements.WaveCell extends Cell 
{
	private var __rotation : Number = 0;
	
	public function WaveCell(x : Number, y : Number, link : MovieClip)
	{
		super(x, y, link);
	}
}
