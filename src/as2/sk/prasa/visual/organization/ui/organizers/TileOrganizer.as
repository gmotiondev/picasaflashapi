import sk.prasa.visual.organization.dimension.Area;
import sk.prasa.visual.organization.ui.elements.Cell;
import sk.prasa.visual.organization.ui.elements.TileCell;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.LayoutOrganizer;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.visual.organization.ui.organizers.TileOrganizer extends LayoutOrganizer implements ILayoutOrganizer 
{
	private var __direction : String = "horizontal";	
	// vertical
	private var __hPadding : Number = 0;
	private var __vPadding : Number = 0;

	public function TileOrganizer(target : MovieClip, w : Number, h : Number, hPadding : Number, vPadding : Number, xOffset : Number, yOffset : Number)
	{
		super(target);
		
		__width = w;
		__height = h;
				
		if(hPadding != null) __hPadding = hPadding;
		if(vPadding != null) __vPadding = vPadding;
		
		__x = xOffset != null ? xOffset : 0;
		__y = yOffset != null ? yOffset : 0;
		
		clearCells();
	}

	public function setX(value : Number) : Void
	{
		__x = value;
		
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}

	public function setY(value : Number) : Void
	{
		__y = value;
		
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}

	public function setWidth(value : Number) : Void
	{
		__width = value;
		
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}

	public function setHeight(value : Number) : Void
	{
		__height = value;
		
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}

	public function setDirection(value : String) : Void
	{
		__direction = value;
		
		adjustLayout();
		
		if(__autoAdjust) apply(__tweenFunction);
	}

	public function getDirection() : String
	{
		return __direction;
	}
	
	public function calculatePosition(index : Number, d : Area) : Object
	{
		var xPos : Number = 0;
		var yPos : Number = 0;
		var tLastCell : TileCell = TileCell(getCellAt(index));
		
		if(tLastCell)
		{
			switch(__direction)
			{
				case "horizontal" :
					if( d.width > (__width - (tLastCell.x + tLastCell.width)) ) {
						xPos = 0; 
						yPos = tLastCell.y + tLastCell.height;
					} else {
						xPos = (tLastCell.x + tLastCell.width + __hPadding);
						yPos = tLastCell.y;
					}
					break;
				case "vertical" :
					if( d.height > (__height - (tLastCell.y + tLastCell.height)) ) {
						xPos = tLastCell.x + tLastCell.width; 
						yPos = 0;
					} else {
						xPos = tLastCell.x;
						yPos = (tLastCell.y + tLastCell.height + __vPadding);
					}
					break; 
			}
		}
		
		return {x : xPos, y : yPos};
	}
	
	public function addToLayout(object : MovieClip, moveToCoordinates : Boolean) : Void
	{
		var tPrevPos : Object = calculatePosition((getTotalCells() - 1), new Area(object._width, object._height));
		var cell : TileCell = new TileCell(tPrevPos.x, tPrevPos.y, object._width, object._height, object);
		
		__cells.push(cell);
		
		if(moveToCoordinates || moveToCoordinates == null) 
		{
			cell.link._x = cell.x; 
			cell.link._y = cell.y;
		}
	}

	public function applyItem(item : MovieClip, tweenFunction : Function) : Void
	{
		var cell : TileCell = TileCell(getCellByLink(item));
		
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

	public function apply(tweenFunction : Function) : Void
	{
		var len : Number = __cells.length;
		for(var a : Number = 0;a < len; a++)
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
			}
		}
	}
	
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
		for(var a : Number = 0; a < __cells.length; a++)
		{
			var tPos : Object = calculatePosition(a - 1, new Area(__cells[a].width, __cells[a].height));
			__cells[a].x = tPos.x;
			__cells[a].y = tPos.y;
		}
	}
}
