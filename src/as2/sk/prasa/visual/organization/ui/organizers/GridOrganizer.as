import sk.prasa.visual.organization.dimension.Area;
import sk.prasa.visual.organization.ui.elements.Cell;
import sk.prasa.visual.organization.ui.elements.GridCell;
import sk.prasa.visual.organization.ui.organizers.LayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.visual.organization.ui.organizers.GridOrganizer extends LayoutOrganizer implements ILayoutOrganizer 
{
	private var __rows : Number;
	private var __columns : Number;
	private var __hPadding : Number = 0;
	private var __yPadding:Number = 0; //TODO: rewrite ti __vPadding
	
	/**
	 * Constructor for GridOrganizer 
	 *
	 * @param  target  DisplayObject where all layout elements will reside
	 * @param  width  total width of the entire grid
	 * @param  height  total height of the entire grid
	 * @param  columns  number of columns in the grid
	 * @param  rows  number of rows in the grid
	 * @param  hPadding  horizontal padding between cells
	 * @param  vPadding  vertical padding between cells
	 * @param  xOffset  x position of grid
	 * @param  yOffset  y position of grid
	 */
	public function GridOrganizer(target : MovieClip, w : Number, h : Number, c : Number, r : Number, hPadding : Number, vPadding : Number, xOffset : Number, yOffset : Number)
	{
		super(target);
		
		__width = w;
		__height = h;
		__rows = r;
		__columns = c;
		if(hPadding) __hPadding = hPadding;
		if(vPadding) __yPadding = vPadding;
		
		__x = xOffset != null ? xOffset : 0;
		__y = yOffset != null ? yOffset : 0;
		
		initGrid();
	}
	
	/**
	 * Accessor for columns property
	 *
	 * @return	Column length   
	 */
	public function getColumns() : Number
	{
		return __columns;
	}
	
	/**
	 * Accessor for rows property
	 *
	 * @return	Row length   
	 */
	public function getRows() : Number
	{
		return __rows;
	}
	
	/**
	 * Mutator for x padding property
	 *
	 * @param	value	X padding of grid cells for layout organizer   
	 */
	public function setPaddingX(value : Number) : Void
	{
		__hPadding = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Mutator for y padding property
	 *
	 * @param	value	X padding of grid cells for layout organizer   
	 */
	public function setPaddingY(value : Number) : Void
	{
		__yPadding = value;
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/**
	 * Accessor for x padding property
	 *
	 * @return	X padding of grid cells for layout organizer   
	 */
	public function getPaddingX() : Number
	{
		return __hPadding;
	}
	
	/**
	 * Accessor for y padding property
	 *
	 * @return	Y padding of grid cells for layout organizer   
	 */
	public function getPaddingY() : Number
	{
		return __yPadding;
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
		
		if(__autoAdjust) this.apply(__tweenFunction);
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
	 * Accessor for cell width property
	 *
	 * @return	Width dimension of layout cell   
	 */
	public function getCellWidth() : Number
	{
		return __cells[0].width;
	}
	
	/**
	 * Accessor for cell height property
	 *
	 * @return	Height dimension of layout cell   
	 */
	public function getCellHeight() : Number
	{
		return __cells[0].height;
	}
	
	/**
	 * Get cell objects by column index
	 *
	 * @param  column  cell index of grid
	 * @return      an array of cell objects by column index
	 * @see         Cell
	 */
	public function getColumn(column : Number) : Array
	{
		var c : Array = new Array();
		
		for(var a : Number = 0; a < __rows; a++)
		{
			c.push(__cells[(a * __columns) + column]);
		}
		
		return c;
	}
	
	/**
	 * Get cell objects by row index
	 *
	 * @param  row  row index of grid
	 * @return      an array of cell objects by row index
	 * @see         Cell
	 */
	public function getRow(row : Number) : Array
	{
		var c : Array = new Array();
		
		for(var a : Number = row * __columns; a < (row * __columns) + __columns; a++)
		{
			c.push(__cells[a]);
		}
		
		return c;
	}
	
	/**
	 * Removes cell link of DisplayObject at specified grid coordinates
	 *
	 * @param  column  column index of grid
	 * @param  row  row index of grid
	 */
	public function removeItemAt(column : Number, row : Number) : Void
	{
		getCellFromCoordinates(column, row).link = null;
	}
	
	/**
	 * Adds cell link of DisplayObject at specified grid coordinates
	 *
	 * @param  column  column index of grid
	 * @param  row  row index of grid
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
	 * @param addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
	 */
	public function addItemAt(object : MovieClip, column : Number, row : Number, moveToCoordinates:Boolean, addToStage:Boolean) : Void
	{
		var cell : GridCell = getCellFromCoordinates(column, row);
			cell.link = object;
			
		if(moveToCoordinates || moveToCoordinates == null)
		{
			object.x = cell.x;
			object.y = cell.y;
		}
		if(addToStage || addToStage == null)
		{
			__target.addChild(object);
		}
	}
	
	/**
	 * Returns cell at specified grid coordinates
	 *
	 * @param  column  column index of grid
	 * @param  row  row index of grid
	 * @return GridCell object from specified coordinates
	 */
	public function getCellFromCoordinates(column : Number, row : Number) : GridCell
	{
		return __cells[(row * __columns) + column];
	}
	
	/**
	 * Adds DisplayObject to layout in next available position
	 *
	 * @param  object  DisplayObject to add to organizer
	 * @param  moveToCoordinates  automatically move DisplayObject to corresponding cell's coordinates
	 * @param  addToStage  adds a child DisplayObject instance to target's DisplayObjectContainer instance
	 */
	public function addToLayout(object : MovieClip, moveToCoordinates : Boolean, addToStage:Boolean) : Void
	{
		var cell : GridCell;
			cell = GridCell(getNextAvailableCell());
		
		if(!cell) return;
		
		cell.link = object;
		
		if(moveToCoordinates || moveToCoordinates == null)
		{
			object.x = cell.x;
			object.y = cell.y;
		}
		
		if(addToStage || addToStage == null)
		{
			__target.addChild(object);
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
		this.adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}
	
	/*PRIVATE METHODS
	-------------------------------------------------*/
	
	private function adjustLayout() : Void
	{
		//var len:Number=this._cells.length;
		var total : Number = __columns * __rows;
		var d : Area = calculateCellSize();
		var c : Number;
		var r : Number;
		
		for(var a : Number = 0; a < total; a++)
		{
			var cell : GridCell = __cells[a];
			if(!cell) break;
			
			c = a % __columns;
			r = Math.floor(a/(total/__rows));
							
			cell.x = ((d.width * c) + (c * __hPadding) + __x);
			cell.y = ((d.height * r) + (r * __yPadding) + __y);
		}
	}
	
	private function calculateCellSize() : Area
	{
		return new Area((__width - ((__columns - 1) * __hPadding)) / __columns, (__height - ((__rows - 1) * __yPadding)) / __rows);
	}
	
	private function initGrid() : Void
	{
		clearCells();
		
		var d : Area = calculateCellSize();
		var total : Number = __columns * __rows;
		var c : Number;
		var r : Number;
		
		for(var a : Number = 0; a < total; a++)
		{
			c = a % __columns;
			r = Math.floor(a/(total/__rows));
			
			var cell : GridCell = new GridCell(c, r, ((d.width * c) + (c * __hPadding) + __x),((d.height * r)+(r * __yPadding) + __y),d.width, d.height);
			__cells.push(cell);
		}
	}
}
