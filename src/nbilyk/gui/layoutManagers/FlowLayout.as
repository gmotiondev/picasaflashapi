/*
	FlowLayout_2_0.as  extends LayoutManager
	Written by: Nicholas Bilyk
	Status: Development

	FlowLayout(root_mc:MovieClip)
		Description: A Layout Manager that positions elements much like Java's FlowLayout class.  (From Left to right, when an element doesn't fit anymore, it moves to the next line.)
		root_mc: the root MovieClip where the objects to be positioned are.
	Functions:
		draw()
			Places all objects in the LayoutManager objects_arr in the correct spots depending on alignment.
		setAlign(align:String)
			Acceptable align values: "left", "center", "right"
				Sets the default horizontal alignment 
		
	Public Properties:
		width:Number: See parent.
		height:Number: See parent.
		hGap:Number: Horizontal buffer between objects
		vGap:Number: Vertical buffer between rows of objects.

	Version: 0.01
*/
import nbilyk.gui.layoutManagers.LayoutManager;
import nbilyk.utility.CoordMath;

class nbilyk.gui.layoutManagers.FlowLayout extends LayoutManager {
	public var className:String = "FlowLayout";
	private var _hGap = 5;
	private var _vGap = 5;
	private var _align:Number;
	public static var LEFT:Number = 0;
	public static var CENTER:Number = 1;
	public static var RIGHT:Number = 2;
	
	function FlowLayout(root_mc:MovieClip) {
		super(root_mc);
	}
	function draw() {
		super.draw();
		var point = { x:this._leftMargin, y:this._topMargin };
		var tallestInRow = 0;
		var position_arr:Array = new Array();
		var rowIndex_arr:Array = new Array();
		var offset_arr:Array = new Array();
		var numObjects = this.objects_arr.length;	
		for (var i=0; i<numObjects; i++) {
			CoordMath.convertCoords(point, this.root_mc, this.objects_arr[i]._parent);			
			position_arr.push({ x:point.x, y:point.y });
			CoordMath.convertCoords(point, this.objects_arr[i]._parent, this.root_mc);
			
			var w = (typeof(this.objects_arr[i].width) == "number") ? this.objects_arr[i].width : this.objects_arr[i]._width; 
			var h = (typeof(this.objects_arr[i].height) == "number") ? this.objects_arr[i].height : this.objects_arr[i]._height;
			var currObjDims = { x:w, y:h };
			CoordMath.convertDistance(currObjDims, this.objects_arr[i]._parent, this.root_mc);
			
			var w = (typeof(this.objects_arr[i+1].width) == "number") ? this.objects_arr[i+1].width : this.objects_arr[i+1]._width;
			var h = (typeof(this.objects_arr[i+1].height) == "number") ? this.objects_arr[i+1].height : this.objects_arr[i+1]._height;
			var nextObjDims = { x:w, y:h };
			CoordMath.convertDistance(nextObjDims, this.objects_arr[i+1]._parent, this.root_mc);
			if (currObjDims.y > tallestInRow) tallestInRow = currObjDims.y;
			if (point.x + currObjDims.x + this._hGap + nextObjDims.x >= this._width - this._rightMargin || i == numObjects - 1) {
				var spaceLeft:Number = this._width - this._rightMargin - currObjDims.x - point.x;
				if (this._align == "center") {					
					offset_arr.push(spaceLeft / 2);
				} else if (this._align == "right") {
					offset_arr.push(spaceLeft);
				} else {
					offset_arr.push(0);
				}
				rowIndex_arr.push(i);
				point.x = this._leftMargin;
				point.y += tallestInRow + this._vGap;
				tallestInRow = 0;
			} else {
				point.x += currObjDims.x + this._hGap;
			}
		}
		
		// Positions are calculated except for alignment, place them now.
		var row = 0;
		for (var i=0; i<numObjects; i++) {
			this.moveObject(this.objects_arr[i], position_arr[i].x + offset_arr[row], position_arr[i].y);
			if (i >= rowIndex_arr[row]) row++;
		}
	}
	private function moveObject(objToMove:Object, newX:Number, newY:Number) {
		objToMove._x = newX;
		objToMove._y = newY
	}
	public function setAlign(newAlign_str:String) {
		var newAlign:Number = this.getAlignFromString(newAlign_str);
		if (this._align != newAlign) {
			this._align = newAlign;
			this.invalidate();
		}
	}
	public function getAlign():Number {
		return this._align;
	}
	private function getAlignFromString(_str:String):Number {
		var _num:Number;
		_str = _str.toLowerCase();
		switch (_str) {
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
	public function set hGap(newHGap:Number) {	
		if (!isNaN(newHGap)) {
			this._hGap = newHGap;
			this.invalidate();
		}
	}
	public function get hGap():Number {
		return this._hGap;
	}
	public function set vGap(newVGap:Number) {
		if (!isNaN(newVGap)) {
			this._vGap = newVGap;
			this.invalidate();
		}
	}
	public function get vGap():Number {
		return this._vGap;
	}
};