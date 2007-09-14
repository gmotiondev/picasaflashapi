/*
	GridLayout_2_2
	Written by: Nicholas Bilyk

	GridLayout_2_2(root_mc:MovieClip, rows:Number, cols:Number)
		Description: A Layout Manager that positions elements much like Java's GridLayout class.
		root_mc: The root MovieClip where the objects to be positioned are.
		rows: The number of rows.
		cols: The number of cols.
	Functions:
		draw()
			Places all objects added by addObj or setObj in the correct spots given properties of the layout manager.
		
		setRowSizes(size1:Number, size2:Number, size3:Number, ...) or (rowSize_arr:Array)
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
/*
 * 
	import nbilyk.gui.layoutManagers.GridLayout_3_0;

	var lm:GridLayout_3_0 = new GridLayout_3_0(this, 3, 4);

	// Add your MovieClip(s) to the layout manager.
	lm.addObj(mc1, mc2, mc3); */

import nbilyk.gui.layoutManagers.LayoutManager;
import nbilyk.utility.CoordMath;

class nbilyk.gui.layoutManagers.GridLayout extends LayoutManager {
	public var className:String = "GridLayout";
	private var _hGap = 5;
	private var _vGap = 5;
	private var _rows = 2;
	private var _cols = 2;
	private var rowSizes_arr:Array;
	private var colSizes_arr:Array;
	private var _fixedSizes:Boolean;
	private var defaultHAlign:Number = 0;
	private var defaultVAlign:Number = 0;
	private var hAlign_arr:Array;
	private var vAlign_arr:Array;
	public static var LEFT:Number = 0;
	public static var CENTER:Number = 1;
	public static var RIGHT:Number = 2;
	public static var TOP:Number = 0;
	public static var MIDDLE:Number = 1;
	public static var BOTTOM:Number = 2;

	public function GridLayout(root_mc:MovieClip, rows:Number, cols:Number)
	{
		super(root_mc);
		if (rows) this._rows = rows;
		if (cols) this._cols = cols;
	}
	public function draw() {		
		var xOffset:Number;
		var yOffset:Number;
		
		super.draw();
		// Calculate fixed sizes if they weren't already set. (sets according to available width and height)
		if (this._fixedSizes && !this.rowSizes_arr.length) this.setRowSizes(); 
		if (this._fixedSizes && !this.colSizes_arr.length) this.setColSizes();
		// Calculates variable sizes based on objects_arr elements' width and height properties.
		if (!this._fixedSizes) this.calculateVariableSizes(); 
		
		// Calculate positioning.
		var position_arr = new Array(this.objects_arr.length);
		var counter = 0;
		var y = this._topMargin;
		for (var i=0; i<this._rows; i++) {
			var x = this._leftMargin;			
			for (var j=0; j<this._cols; j++) {				
				// Horizontal alignment.
				var hAlign = this.defaultHAlign;
				if (this.hAlign_arr[j] != undefined) hAlign = this.hAlign_arr[j];
				if (this.objects_arr[counter].hAlign != undefined) hAlign =  this.objects_arr[counter].hAlign;
				var w = (typeof(this.objects_arr[counter].width) == "number") ? this.objects_arr[counter].width : this.objects_arr[counter]._width;
				if (hAlign == CENTER) {
					xOffset = this.colSizes_arr[j]/2 - w/2 - this._hGap/2;
				} else if (hAlign == RIGHT) {
					xOffset = this.colSizes_arr[j] - w - this._hGap;
				} else {
					// LEFT
					xOffset = 0;
				}
				// Vertical alignment.
				var vAlign = this.defaultVAlign;
				if (this.vAlign_arr[i] != undefined) vAlign = this.vAlign_arr[i];
				if (this.objects_arr[counter].vAlign != undefined) vAlign =  this.objects_arr[counter].vAlign;
				var h = (typeof(this.objects_arr[counter].height) == "number") ? this.objects_arr[counter].height : this.objects_arr[counter]._height;
				if (vAlign == MIDDLE) {
					yOffset = this.rowSizes_arr[i]/2 - h/2 - this._vGap/2;
				} else if (vAlign == BOTTOM) {
					yOffset = this.rowSizes_arr[i] - h - this._vGap;
				} else {
					// TOP
					yOffset = 0;
				}
				
				position_arr[counter] = { x:x+xOffset, y:y+yOffset };
				x += this.colSizes_arr[j];
				counter++;
			}
			y += this.rowSizes_arr[i];
		}
		var l = position_arr.length;
		for (var i=0; i<l; i++) {
			CoordMath.convertCoords(position_arr[i], this.root_mc, this.objects_arr[i]._parent);
			this.moveObject(this.objects_arr[i], position_arr[i].x, position_arr[i].y);
		}
	}
	private function moveObject(objToMove:Object, newX:Number, newY:Number) {
		objToMove._x = newX;
		objToMove._y = newY
	}
	private function calculateVariableSizes() {
		// appropriate widths
		this.colSizes_arr = new Array(this._cols);
		for (var c=0; c<this._cols; c++) {
			var maxWidth = 0;
			for (var r=0; r<this._rows; r++) {
				var objectIndex = c+r*this._cols;				
				var w = (typeof(this.objects_arr[objectIndex].width) == "number") ? this.objects_arr[objectIndex].width : this.objects_arr[objectIndex]._width;
				var currObjDims = { x:w, y:0 };
				CoordMath.convertDistance(currObjDims, this.objects_arr[objectIndex]._parent, this.root_mc);
				if (currObjDims.x > maxWidth) maxWidth = currObjDims.x;					
			}
			var cArrIndex = c;
			this.colSizes_arr[cArrIndex] = maxWidth + this._hGap;
		}
		// appropriate heights
		this.rowSizes_arr = new Array(this._rows);
		for (var r=0; r<this._rows; r++) {
			var maxHeight = 0;
			for (var c=0; c<this._cols; c++) {
				var objectIndex = c+r*this._cols;
				var h = (typeof(this.objects_arr[objectIndex].height) == "number") ? this.objects_arr[objectIndex].height : this.objects_arr[objectIndex]._height;
				var currObjDims = { x:0, y:h };
				CoordMath.convertDistance(currObjDims, this.objects_arr[objectIndex]._parent, this.root_mc);
				if (currObjDims.y > maxHeight) maxHeight = currObjDims.y;
			}
			var rArrIndex = r;
			this.rowSizes_arr[rArrIndex] = maxHeight+this._vGap;
		}
	}
	public function setRowSizes():Void {
		if (typeof(arguments[0][0]) == "number") {
			this.rowSizes_arr = arguments[0];
		} else {
			this.rowSizes_arr = arguments;
		}
		var totalSize = 0;
		var l = this._rows;
		for (var i=0; i<l; i++) {
			if (isNaN(this.rowSizes_arr[i])) {
				this.rowSizes_arr[i] = (this.height - totalSize - this._topMargin - this._bottomMargin) / (l - i);
			} 
			totalSize += this.rowSizes_arr[i];			
		}
	}
	public function getRowSizes():Array {
		return this.rowSizes_arr;
	}
	public function setColSizes():Void {
		if (typeof(arguments[0][0]) == "number") {
			this.colSizes_arr = arguments[0];
		} else {
			this.colSizes_arr = arguments;
		}
		var totalSize = 0;
		var l = this._cols;
		for (var i=0; i<l; i++) {
			if (isNaN(this.colSizes_arr[i])) {				
				this.colSizes_arr[i] = (this.width - totalSize - this._leftMargin - this._rightMargin) / (l - i);
			}
			totalSize += this.colSizes_arr[i];			
		}
	}
	public function getColSizes():Array {
		return this.colSizes_arr;
	}
	public function set fixedSizes(newFixedSizes:Boolean) {
		this._fixedSizes = newFixedSizes;
		this.invalidate();
	}
	public function get fixedSizes():Boolean { 
		return this._fixedSizes; 
	}
	public function set hGap(newHGap:Number) {		
		this._hGap = newHGap;
		this.invalidate();
	}
	public function get hGap():Number {
		return this._hGap;
	}
	public function set vGap(newVGap:Number) {		
		this._vGap = newVGap;
		this.invalidate();
	}
	public function get vGap():Number {
		return this._vGap;
	}
	public function set rows(newRows:Number) {
		this._rows = newRows;
		this.invalidate();
	}
	public function get rows():Number {
		return this._rows;
	}
	public function set cols(newCols:Number) {
		this._cols = newCols;
		this.invalidate();
	}
	public function get cols():Number {
		return this._cols;
	}
	public function setAlign() {
		// usage 1: default horizontal alignment
		var root_obj = this;		
		var argumentsL = arguments.length;
		if (argumentsL == 1) {
			this.defaultHAlign = this.getAlignFromString(String(arguments[0]));
			return undefined;
		}
		// usage 2: align1, align2, align3, etc
		this.hAlign_arr = new Array(this._cols);
		for (var i=0; i<this._cols; i++) {
			this.hAlign_arr[i] = this.getAlignFromString(String(arguments[i]));
		}
	}
	public function setVAlign() {
		// usage 1: default vertical alignment
		var root_obj = this;		
		var argumentsL = arguments.length;
		if (argumentsL == 1) {
			this.defaultVAlign = this.getAlignFromString(String(arguments[0]));
			return undefined;
		}
		// usage 2: valign1, valign2, valign3, etc
		this.vAlign_arr = new Array(this._rows);
		for (var i=0; i<this._rows; i++) {
			this.vAlign_arr[i] = this.getAlignFromString(String(arguments[i]));
		}
	}
	private function getAlignFromString(_str:String):Number {
		var _num:Number;
		_str = _str.toLowerCase();
		switch (_str) {
			case ("bottom") :
				_num = BOTTOM;
				break;
			case ("middle") :
				_num = MIDDLE;
				break;
			case ("top") :
				_num = TOP;
				break;
			case ("right") :
				_num = RIGHT;
				break;
			case ("center") :
				_num = CENTER;
				break;
			case ("left") :
				_num = LEFT;
				break;
			default :
				_num = 0;
		}
		return _num;
	}
	public function setObj(row:Number, col:Number, newObj:Object):Boolean {		
		if ((typeof(newObj._width) == "number" && typeof(newObj._height) == "number") || (typeof(newObj.width) == "number" && typeof(newObj.height) == "number")) {
			var objectIndex = col+row*this._cols;
			this.objects_arr[objectIndex] = newObj;
			if (this._rows < row+1) this._rows = row+1;
			if (this._cols < col+1) this._cols = col+1;
			this.invalidate();
			return true;
		}		
		return false;
	}	
	public function getObj(row:Number, col:Number):Object {
		var objectIndex = col+row*this._cols;
		return this.objects_arr[objectIndex];
	}
};