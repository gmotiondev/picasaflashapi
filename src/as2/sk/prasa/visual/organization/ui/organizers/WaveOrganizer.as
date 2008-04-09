import sk.prasa.visual.organization.ui.elements.Cell;
import sk.prasa.visual.organization.ui.elements.WaveCell;
import sk.prasa.visual.organization.ui.organizers.LayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.organizers.WaveOrganizer extends LayoutOrganizer implements ILayoutOrganizer 
{
	private var __frequency : Number = 1;
	private var __waveFunction : String = WaveOrganizer.SINE;
	private var __function : Function = Math.sin;
	
	public static var SINE : String = "sineFunction";
	public static var COSINE : String = "cosineFunction";
	public static var TAN : String = "tanFunction";

	/**
	 * Constructor for WaveOrganizer 
	 *
	 * @param  target  DisplayObject where all layout elements will reside
	 * @param  width  total width of the entire grid
	 * @param  height  total height of the entire grid
	 * @param  xOffset  x position of grid
	 * @param  yOffset  y position of grid
	 * @param  frequency  frequency of wave function
	 * @param  waveFunction  type of wave function (sin, cos, tan)
	 */
	public function WaveOrganizer(target : MovieClip, w : Number, h : Number, xOffset : Number, yOffset : Number, frequency : Number, wf : String)
	{
		super(target);
		
		__cells = new Array();
		__width = w;
		__height = h;
		__x = xOffset != null ? xOffset : 0;
		__y = yOffset != null ? yOffset : 0;
		__frequency = frequency != null ? frequency : __frequency;
		__waveFunction = wf != null ? wf : __waveFunction;
	}
	
	/**
	 * Mutator for waveFunction property
	 *
	 * @param	value	Wave function of layout organizer   
	 */
	public function setWaveFunction(value : String) : Void
	{
		switch(value)
		{
			case WaveOrganizer.SINE:
				__waveFunction = value;
				__function = Math.sin;
				break;
			case WaveOrganizer.COSINE:
				__waveFunction = value;
				__function = Math.cos;
				break;
			case WaveOrganizer.TAN:
				__waveFunction = value;
				__function = Math.tan;
				break;
		}
		
		adjustLayout();
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Accessor for waveFunction property
	 *
	 * @return	Wave function in string form   
	 */
	public function getWaveFunction() : String
	{
		return __waveFunction;
	}

	/**
	 * Mutator for frequency property
	 *
	 * @param	value	Wave frequency of layout organizer   
	 */
	public function setFrequency(value : Number) : Void
	{
		__frequency=value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Accessor for frequency property
	 *
	 * @return	Frequency of wave   
	 */
	public function getFrequency() : Number
	{
		return __frequency;
	}
	
	/**
	 * Mutator for x property
	 *
	 * @param	value	Global X position of layout organizer   
	 */
	public function setX(value : Number) : Void
	{
		__x = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Mutator for y property
	 *
	 * @param	value	Global Y position of layout organizer   
	 */
	public function setY(value : Number) : Void
	{
		__y = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Mutator for width property
	 *
	 * @param	value	Global width dimension of layout organizer   
	 */
	public function setWidth(value : Number) : Void
	{
		__width = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Mutator for height property
	 *
	 * @param	value	Global height dimension of layout organizer   
	 */
	public function setHeight(value : Number) : Void
	{
		__height = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Adds DisplayObject to layout in next available position
	 *
	 * @param  object  DisplayObject to add to organizer
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
	 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
	 */
	public function addToLayout(object : MovieClip,  moveToCoordinates : Boolean) : Void
	{
		var cell : WaveCell = new WaveCell(0, 0, object);
		
		__cells.push(cell);
		
		var len : Number = this.__cells.length;

		for(var a : Number = 0; a < len; a++)
		{
			var c : WaveCell = __cells[a];
			c.x = (a * (__width / len)) + __x;
			c.y = (__function(Math.PI * (a + 1) / (len / 2)) * (__height / 2)) + (__height / 2) + __y;
		}
		
		if(moveToCoordinates || moveToCoordinates == null)
		{
			apply();
		}
	}
	
	/**
	 * Removes specified cell and its link from layout organizer and adjusts layout appropriately
	 *
	 * @param  cell  cell object to remove
	 */
	public function removeCell(cell : Cell) : Void
	{
		super.removeCell(cell);
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/*PRIVATE METHODS
	-------------------------------------------------*/
	private function adjustLayout() : Void
	{
		var len : Number = __cells.length;
		
		for(var a : Number = 0; a < len; a++)
		{
			var c : Cell = __cells[a];
			
			c.x = (a * (__width / len)) + __x;
			c.y = (__function(Math.PI * (a + 1) / (len / 2) * __frequency) * (__height / 2)) + (__height / 2) + __y;
		}
	}
}
