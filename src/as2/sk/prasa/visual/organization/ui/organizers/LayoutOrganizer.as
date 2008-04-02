/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.organization.ui.elements.Cell;
class sk.prasa.visual.organization.ui.organizers.LayoutOrganizer 
{
	private var __target : MovieClip;
	private var __cells : Array;
	
	private var __x : Number = 0;
	private var __y : Number = 0;
	private var __width : Number;
	private var __height : Number;
	
	private var __tweenFunction : Function = null;
	private var __autoAdjust : Boolean;
	
	/**
	 *
	 * @param  target  The object to contain all items managed by LayoutOrganizer
	 */
	public function LayoutOrganizer(target : MovieClip)
	{
		__target = target;
	}
	
	public function setTweenFunction(value : Function) : Void
	{
		__tweenFunction = value;
	}
	
	/**
	 * Specifies whether layout properties (x, y, width, height, etc.) adjust the layout 
	 * automatically without calling apply() method 
	 *
	 * @param  value   
	 * @see    LayoutOrganizer#apply(Function tweenFunction)
	 */
	public function setAutoAdjustLayout(value : Boolean) : Void
	{
		__autoAdjust = value;
	}
	
	/*
	 * @return  Current setting of auto-adjust (defaults to false)   
	 */
	public function get autoAdjustLayout() : Boolean
	{
		return __autoAdjust;
	}
	
	/**
	 * Returns the number of cells currently stored and managed
	 *
	 * @return  Total number of cells   
	 */
	public function getTotalCells() : Number
	{
		return __cells.length;
	}
	
	/**
	 * Returns an array of cell objects
	 *
	 * @return	Array containing all cell objects     
	 */
	public function getCells() : Array
	{
		return __cells;
	}
	
	/**
	 * Accessor for layout x property
	 *
	 * @return	X position of layout organizer   
	 */
	public function getX() : Number
	{
		return __x;
	}
	
	/**
	 * Accessor for layout y property
	 *
	 * @return	Y position of layout organizer   
	 */
	public function getY() : Number
	{
		return __y;
	}
	
	/**
	 * Accessor for layout width property
	 *
	 * @return	Width of layout organizer   
	 */
	public function getWidth() : Number
	{
		return __width;
	}
	
	/**
	 * Accessor for layout height property
	 *
	 * @return	Height position of layout organizer   
	 */
	public function getHeight() : Number
	{
		return __height;
	}
	
	/**
	 * Accessor for layout target
	 *
	 * @return	Display target of layout organizer   
	 */
	public function getTarget() : MovieClip
	{
		return __target;
	}
	
	
	
	/**
	 * Returns cell object by specified display object
	 *
	 * @param  link  an absolute URL giving the base location of the image
	 * @return      the cell object which the display object is linked to
	 * @see         Cell
	 */
	public function getCellByLink(link : MovieClip) : Cell
	{
		for(var a : Number; a < __cells.length; a++)
		{
			if(__cells[a].link == link) return __cells[a];
		}
		
		return null;
	}
	
	/**
	 * Returns specified cell object's index in the collection 
	 *
	 * @param  cell  cell object from layout organizer
	 * @return      index of cell object in the collection of cells
	 * @see         Cell
	 */
	public function getCellIndex(cell : Cell):Number
	{
		for(var a : Number = 0; a < __cells.length; a++)
		{
			if(__cells[a] == cell) return a;
		}
		
		return null;
	}
	
	/**
	 * Returns cell object at specified index of collection
	 *
	 * @param  index  index of item in the collection of cells
	 * @return      cell object at the specified location in the collection
	 * @see         Cell
	 */
	public function getCellAt(index : Number) : Cell
	{
		return __cells[index];
	}
	
	/**
	 * Applies all layout property values to a specified index in the collection
	 *
	 * @param  item  display object 
	 * @param  tweenFunction  function with a Cell parameter for managing the motion of the cell object
	 */
	public function applyAt(index : Number, tweenFunction : Function) : Void
	{
		if(tweenFunction != null)
		{
			 tweenFunction(__cells[index]);
		} else
		{
			__cells[index].link._x = __cells[index].x;
			__cells[index].link._y = __cells[index].y;
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
		var cell : Cell = getCellByLink(item);
		
		if(!cell) return;
		
		if(tweenFunction != null)
		{
			tweenFunction(cell);
		} else
		{
			cell.link._x = cell.x;
			cell.link._y = cell.y;
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
		var c:Cell;
		
		for(var a : Number = 0; a < len; a++)
		{
			c = __cells[a];
			if(tweenFunction != null)
			{
				tweenFunction(c);
			} else if(__tweenFunction != null)
			{
				__tweenFunction(c);
			} else
			{
				c.link._x = c.x;
				c.link._y = c.y;
			}
		}
	}
	
	/**
	 * Removes all links between cells and display objects 
	 *
	 */
	public function removeLinks() : Void
	{
		for(var a : Number = 0; a < __cells.length; a++)
		{
			__cells[a].link = null;
		}
	}
	
	/**
	 * Removed the link between cell and display object at the specified index
	 *
	 * @param  index  index in collection of item to be removed
	 */
	public function removeLinkAt(index : Number) : Void
	{
		__cells[index].link = null;
	}
	
	public function removeCell(cell : Cell) : Void
	{
		__cells.splice(getCellIndex(cell), 1);
	}
	
	/**
	 * Adds a link between the specified display object to the cell object at the specified index
	 *
	 * @param  object	item to add to collection
	* @param  index		position where to add the item
	 */
	public function addLinkAt(object : MovieClip, index : Number) : Void
	{
		__cells[index].link = object;
	}
			
	private function getNextAvailableCell() : Cell
	{
		for(var a : Number = 0; a < __cells.length; a++)
		{
			if(!__cells[a].link) 
			{
				return __cells[a];
			}
		}
		
		return null;
	}
	
	private function clearCells() : Void
	{
		if(__cells)
		{
			for(var a : String in __cells)
			{
				delete __cells[a];
				__cells[a] = null;
			}
		}
		
		__cells = new Array();
	}
}