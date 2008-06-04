import sk.prasa.visual.organization.ui.elements.Cell;
import sk.prasa.visual.organization.ui.elements.EllipseCell;
import sk.prasa.visual.organization.ui.organizers.LayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 * Based on:
 * Actionscript 3 Layout Organizers by P.J. Onori
 * http://www.somerandomdude.net/blog/flash/actionscript-3-layout-organizers-source-code
 */

class sk.prasa.visual.organization.ui.organizers.EllipseOrganizer extends LayoutOrganizer implements ILayoutOrganizer 
{
	private var __rotation : Number = 0;
	
	/**
	 * Constructor for EllipseOrganizer 
	 *
	 * @param  target  DisplayObject where all layout elements will reside
	 * @param  width  total width of the entire ellipse
	 * @param  height  total height of the entire ellipse
	 * @param  xOffset  x position of ellipse
	 * @param  yOffset  y position of ellipse
	 * @param rotation  global rotation of ellipse organizer
	 */
	public function EllipseOrganizer(target : MovieClip, w : Number, h : Number, xOffset : Number, yOffset : Number, r : Number)
	{
		super(target);
		__cells = new Array();
		__width = w;
		__height = h;
		__x = xOffset;
		__y = yOffset;
		__rotation = r != null ? r : __rotation;
	}
	
	/**
	 * Accessor for eccentricity property
	 *
	 * @return	eccentricity  Eccentricity of ellipse  
	 */
	public function getEccentricity() : Number
	{
		var a : Number = (__width > __height) ? __width/2 : __height/2;
		var b : Number = (__width > __height) ? __height/2 : __width/2;
		var e : Number = Math.sqrt(1 - (Math.pow(b,2) / Math.pow(a,2)));
		
		return e;
	}
	
	/**
	 * Mutator for rotation property
	 *
	 * @param	value	Global rotation position of layout organizer   
	 */
	public function setRotation(value : Number) : Void
	{
		__rotation = value;
		adjustLayout();
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	public function getRotation():Number
	{
		return __rotation;
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
		__height=value;
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
		var cell : EllipseCell = new EllipseCell(0, 0, 0, object);
		__cells.push(cell);
		
		adjustLayout();
		
		if(moveToCoordinates || moveToCoordinates == null)
		{
			apply(__tweenFunction);
		}
	}
	
	/**
	 * Applies all layout property values to a specified cells/display objects in the collection
	 *
	 * @param  item  display object 
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	public function applyItem(item : MovieClip, tweenFunction : Function) : Void
	{
		var cell : EllipseCell = EllipseCell(getCellByLink(item));
		
		if(!cell) return;
		
		if(tweenFunction != null) {
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
		var c : EllipseCell;
		
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
				c = __cells[a];
				c.link._x = c.x;
				c.link._y = c.y;
				c.link._rotation = c.rotation;
			}
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
	
	/**
	 * Returns angle of position of specified cell in degrees 
	 *
	 * @param  cell  cell object
	 */
	public function getCellAngle(cell : Cell) : Number
	{
		var xR : Number = cell.link._x - (__x + __width/2);
		var yR : Number = cell.link._y - (__y + __height/2);
		
		var rads : Number = Math.atan2(yR * (__width/__height), xR);
		var a : Number = rads * (180/Math.PI) + 90;
		
		return a;
	}
	
	/**
	 * Sets angle of position of specified cell in degrees 
	 *
	 * @param  cell  cell object
	 * @param  angle angle of cell in degrees
	 */
	public function setCellAngle(cell : Cell, angle : Number) : Void
	{
		//var angle : Number = getCellAngle(cell);
		__rotation = __rotation - angle;
	}
	
	
	/*PRIVATE METHODS
	-------------------------------------------------*/
	
	private function adjustLayout() : Void
	{
		var len : Number = __cells.length;
		var w : Number = __width/2;
		var h : Number = __height/2;
		var rOffset : Number = __rotation * (Math.PI / 180);
		var rad : Number;
		var c : EllipseCell;
		
		for(var a : Number = 0; a < len; a++)
		{	
			c = __cells[a];
			rad = ((Math.PI * (a)) / (len / 2)) + rOffset;
							
			c.x = (w * Math.cos(rad)) + (w + __x);
			c.y = (h * Math.sin(rad)) + (h + __y);
		}
	}
	
	/**
	 * Moves all elements along the eliptical path so that the specified cell is at the top of the ellipse
	 *
	 * @param  cell  cell object to move
	 */
	private function rotateCellToTop(cell : Cell) : Number
	{
		var xR : Number = cell.link._x - (__x + __width/2);
		var yR : Number = cell.link._y - (__y + __height/2);
		
		var rads : Number = Math.atan2(yR * (__width/__height), xR);
		
		//rotation of individual object
		var a : Number = rads * (180 / Math.PI) + 90;
		
		__rotation = __rotation - a;
		
		return a;
	}
}
