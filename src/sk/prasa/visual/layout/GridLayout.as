import com.bourre.structures.Point;
import com.bourre.log.PixlibStringifier;


import sk.prasa.visual.tools.MathUtils;
import sk.prasa.visual.layout.LayoutManager;
import sk.prasa.visual.layout.OGrid;


class sk.prasa.visual.layout.GridLayout extends LayoutManager
{
	private var __hGap:Number = 0;
	private var __vGap:Number = 0;
	private var __rows:Number = 2;
	private var __cols:Number = 2;

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
				tRowSizes[b] = Math.max((tRowSizes[b] == undefined ? 0 : tRowSizes[b]), (tRow[b]._width == undefined ? 0 : tRow[b]._width));
			}
		}
		
		for(var a = 0; a < __grid.getSize().x; a++)
		{
			var tCol = __grid.getColumn(a);

			for(var b = 0; b < tCol.length; b++) {
				tColSizes[b] = Math.max((tColSizes[b] == undefined ? 0 : tColSizes[b]), (tCol[b]._height == undefined ? 0 : tCol[b]._height));
			}
		}
		
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
	
	public function get padding():Number
	{
		return __hGap;
	}
	
	public function set padding(a:Number)
	{
		__hGap = a;
		__vGap = a;
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}