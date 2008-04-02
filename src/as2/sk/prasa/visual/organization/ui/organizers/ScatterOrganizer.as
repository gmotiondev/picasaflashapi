import sk.prasa.visual.organization.ui.elements.ScatterCell;
import sk.prasa.visual.organization.ui.organizers.LayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.visual.organization.ui.organizers.ScatterOrganizer extends LayoutOrganizer implements ILayoutOrganizer 
{	
	private var __tempX : Number = 0;
	private var __tempY : Number = 0;
	private var __tempWidth : Number = 0;
	private var __tempHeight : Number = 0;
	
	private var __jitter : Number = 1;
	private var __jitterRotation : Boolean = false;
	
	/**
	 * Constructor for ScatterOrganizer 
	 *
	 * @param  target  DisplayObject where all layout elements will reside
	 * @param  width  total width of the entire scatter
	 * @param  height  total height of the entire scatter
	 * @param  jitter  jitter multiplier of scatter
	 * @param  xOffset  x position of scatter
	 * @param  yOffset  y position of scatter
	 * @param  jitterRotation  jitter rotation toggle multiplier of scatter
	 */
	public function ScatterOrganizer(target : MovieClip, w : Number, h : Number, jitter : Number, xOffset : Number, yOffset : Number, jitterRotation : Boolean)
	{
		super(target);
		
		__width = w;
		__tempWidth = w;
		__height = h;
		__tempHeight = h;
		__x = xOffset != null ? xOffset : 0;
		__y = yOffset != null ? yOffset : 0;
		__tempX = xOffset != null ? xOffset : 0;
		__tempY = yOffset != null ? yOffset : 0;
		__jitter = jitter;
		__jitterRotation = jitterRotation;
		__cells = new Array();
	}
	
	/**
	 * Mutator for x property
	 *
	 * @param	value	Global X position of layout organizer   
	 */
	public function setX(value:Number):Void
	{
		__tempX = __x;
		__x = value;
		
		adjustX();
		
		if(__autoAdjust) apply(__tweenFunction);
		__tempX = value;
	}
	
	/**
	 * Mutator for y property
	 *
	 * @param	value	Global Y position of layout organizer   
	 */
	public function setY(value : Number) : Void
	{
		__tempY = __y;
		__y = value;
		
		adjustY();
		
		if(__autoAdjust) apply(__tweenFunction);
		__tempY = value;
	}
	
	/**
	 * Mutator for width property
	 *
	 * @param	value	Global width dimension of layout organizer   
	 */
	public function setWidth(value : Number) : Void
	{
		__tempWidth = __width;
		__width = value;
		
		adjustWidth();
		
		if(__autoAdjust) apply(__tweenFunction);
		__tempWidth = value;
	}
	
	/**
	 * Mutator for height property
	 *
	 * @param	value	Global height dimension of layout organizer   
	 */
	public function setHeight(value : Number) : Void
	{
		__tempHeight = __height;
		__height = value;
		
		adjustHeight();
		
		if(__autoAdjust) apply(__tweenFunction);
		__tempHeight = value;
	}
	
	/**
	 * Mutator for jitter property
	 *
	 * @param	value	Global jitter value of layout organizer   
	 */
	public function setJitter(value : Number) : Void
	{
		__jitter = value;
	}
	
	/**
	 * Accessor for jitter property
	 *
	 * @return	Global jitter value of layout organizer   
	 */
	public function getJitter() : Number
	{
		return __jitter;
	}
		
	/**
	 * Adds DisplayObject to layout in next available position
	 *
	 * @param  object  DisplayObject to add to organizer
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
	 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
	 */	
	public function addToLayout(object : MovieClip, moveToCoordinates : Boolean, addToStage : Boolean) : Void
	{
		var p : Number = (Math.round(Math.random())) ? -1 : 1;
		
		var xPos : Number = (__width/2 + ((Math.random() * __width * __jitter)/2) * p) + __x;
			p = (Math.round(Math.random())) ? -1 : 1;
		
		var yPos : Number = (__height/2 + ((Math.random() * __height * __jitter)/2) * p) + __y;
			p = (Math.round(Math.random())) ? -1 : 1;
		var cell : ScatterCell = new ScatterCell(xPos, yPos, (__jitterRotation) ? (Math.random() * p * 360) : 0, object);
		
		__cells.push(cell);
		
		if(moveToCoordinates || moveToCoordinates == null) 
		{
			cell.link._x = cell.x; 
			cell.link._y = cell.y;
			cell.link._rotation = cell.rotation;
		}
		if(addToStage || addToStage == null)
		{
			__target.addChild(cell.link);
		}
	}
	
	/**
	 * Applies all layout property values to a specified cells/display objects in the collection
	 *
	 * @param  item  display object 
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	public function applyItem(item:MovieClip, tweenFunction : Function) : Void
	{
		var cell : ScatterCell = ScatterCell(getCellByLink(item));
		
		if(!cell) return;
		
		if(tweenFunction != null)
		{
			tweenFunction(cell);
		} else
		{
			cell.link._x = cell.x;
			cell.link._y = cell.y;
			cell.link._rotation = cell.rotation;
		}
	}
	
	/**
	 * Applies all layout property values to all cells/display objects in the collection
	 *
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	public function apply(tweenFunction : Function) : Void
	{
		var len : Number = __cells.length;
		for(var a : Number = 0; a < len; a++)
		{
			if(tweenFunction != null)
			{
				tweenFunction(__cells[a]);
			} else if(__tweenFunction != null)
			{
				__tweenFunction(__cells[a]);
			} else
			{
				__cells[a].link._x = __cells[a].x;
				__cells[a].link._y = __cells[a].y;
				__cells[a].link._rotation = __cells[a].rotation;
			}
		}
	}
	
	/**
	 * Re-scatters layout and adjusts cell links appropriately
	 *
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	public function scatter(tweenFunction : Function) : Void
	{
		var p : Number;
		var xPos : Number;
		var yPos : Number;
		var len : Number = __cells.length;
		
		for(var a : Number = 0; a < len; a++)
		{
			p = (Math.round(Math.random())) ? -1 : 1;
			xPos = (__width/2 + ((Math.random() * __width * __jitter)/2) * p) + __x;
			p = (Math.round(Math.random())) ? -1 : 1;
			yPos = (__height/2 + ((Math.random() * __height * __jitter)/2) * p) + __y;
			
			__cells[a].x = xPos;
			__cells[a].y = yPos;
		}
		
		apply(tweenFunction);
	}
	
	/*PRIVATE METHODS
	-------------------------------------------------*/

	private function adjustWidth() : Void
	{
		var len : Number = __cells.length;
		var r : Number = (__width/(__tempWidth));
		
		for(var a : Number = 0; a < len; a++)
		{
			__cells[a].x = (r * (__cells[a].x - __x)) + __x;
		}
	}
	
	private function adjustHeight() : Void
	{
		var len : Number = __cells.length;
		var r : Number = (__height/(__tempHeight));
		
		for(var a : Number = 0; a < len; a++)
		{
			__cells[a].y = (r * (__cells[a].y - __y)) + __y;
		}
	}
	
	private function adjustX() : Void
	{
		var len : Number = __cells.length;
		
		for(var a : Number = 0; a < len; a++)
		{
			__cells[a].x = (__cells[a].x) + (__x - __tempX);
		}
	}
	
	private function adjustY() : Void
	{
		var len : Number = __cells.length;
		
		for(var a : Number = 0; a < len; a++)
		{
			__cells[a].y = (__cells[a].y) + (__y - __tempY);
		}
	}
}
