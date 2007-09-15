import com.bourre.structures.Point;
import com.bourre.log.PixlibStringifier;

import Picasa.tools.layout.LayoutManager;
import Picasa.tools.OGrid;
import Picasa.tools.MathUtils;

/*
	GridLayout_2_2(root_mc:MovieClip, rows:Number, cols:Number)
		Description: A Layout Manager that positions elements much like Java's GridLayout class.
		root_mc: The root MovieClip where the objects to be positioned are.
		rows: The number of rows.
		cols: The number of cols.
	Functions:
		draw()
			Places all objects added by addObj or setObj in the correct spots given properties of the layout manager.
		
		setRowSizes(size1:Number, size2:Number, size3:Number, ...)
			(property fixedSizes  must be set to true)
			Whichever rows are set, those rows will be a fixed size. Whichever rows are not set, will be evenly distributed the remaining space.
			
		setColSizes(size1, size2, size3, ...) or (colSize_arr:Array)
			(property fixedSizes  must be set to true)
			Whichever cols are set, those cols will be a fixed size. Whichever cols are not set, will be evenly distributed the remaining space.
		
		setAlign()
			Acceptable align values: "left", "center", "right"
			usage 1:
				(align:String)
					Sets the default horizontal alignment 
			usage 2:
				(align1:String, align2:String, align3:String, ...)
					Sets each column's horizontal alignment.
			
		setVAlign()
			Acceptable valign values: "top", "middle", "bottom"
				usage 1:
					(valign:String)
						Sets the default vertical alignment 
				usage 2:
					(valign1:String, valign2:String, valign3:String, ...)
						Sets each row's vertical alignment.
		
		addObj(newObj:Object)
			Adds newObj to the layout manager in the order of:
				1 2 3 4
				5 6 7 8
			
		setObj(row:Number, col:Number, newObj:Object)
			Sets [row][col] to newObj.  (Not updated until draw() is called.		
		
		
	Public Properties:
		width:Number: See parent.
		height:Number: See parent.
		hGap:Number: Horizontal buffer between columns
		vGap:Number: Vertical buffer between rows.
		rows:Number: Number of rows
		cols:Number: Number of columns
		fixedSizes:Boolean: If this is false (default) the rows and columns will be the size of the largest object in that row or column.
		NOTE: fixedSizes must be set to true if you want the sizes you set in setRowSizes or setColSizes to apply.
*/

class Picasa.tools.layout.GridLayout extends LayoutManager
{
	private var __hGap:Number = 5;
	private var __vGap:Number = 5;
	private var __rows:Number = 2;
	private var __cols:Number = 2;
	
//	private var rowSizes_arr:Array;
//	private var colSizes_arr:Array;
	
//	private var __fixed:Boolean = false;
//	private var defaultHAlign:Number = 0;
//	private var defaultVAlign:Number = 0;
	
//	private var hAlign_arr:Array;
//	private var vAlign_arr:Array;
	
//	public static var LEFT:Number = 0;
//	public static var CENTER:Number = 1;
//	public static var RIGHT:Number = 2;
//	public static var TOP:Number = 0;
//	public static var MIDDLE:Number = 1;
//	public static var BOTTOM:Number = 2;

	private var __grid:OGrid;
	
	public function GridLayout(r:Number, c:Number)
	{
		super();
		
		__rows = (r != undefined) ? r : __rows;
		__cols = (c != undefined) ? c : __cols;
		
		__grid = new OGrid(__cols, __rows);
	}
	
	private function initialize()
	{
		__grid.setContent(getChildren());
	}
	
	public function draw():Void
	{
		initialize();
		
		var tRowSizes:Array = [];
		var tColSizes:Array = [];
				
		for(var a = 0; a < __grid.getSize().y; a++)
		{
			var tRow = __grid.getRow(a);

			for(var b = 0; b < tRow.length; b++) {
				tRowSizes[b] = Math.max((tRowSizes[b] == undefined ? 0 : tRowSizes[b]), tRow[b]._width);
			}
		}
		
		for(var a = 0; a < __grid.getSize().x; a++)
		{
			var tCol = __grid.getColumn(a);

			for(var b = 0; b < tCol.length; b++) {
				tColSizes[b] = Math.max((tColSizes[b] == undefined ? 0 : tColSizes[b]), tCol[b]._height);
			}
		}
		
		//trace("tRowSizes: "+tRowSizes+", tColSizes: "+tColSizes);
		
		for(var a = 0; a < __grid.getArea(); a++)
		{
			var tItemPoint = __grid.getCoordinates(a);
			var tItem = __grid.getVal(tItemPoint);
			
			move(tItem, new Point(MathUtils.addRange(tRowSizes, 0, tItemPoint.x, __hGap),MathUtils.addRange(tColSizes, 0, tItemPoint.y, __vGap)));
		}
		
		broadcastComplete();	
	}
	
	private function move(o:Object, p:Point) {
		o._x = p.x;
		o._y = p.y;
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}