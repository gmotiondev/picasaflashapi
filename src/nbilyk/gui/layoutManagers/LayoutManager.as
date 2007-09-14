/*
	LayoutManager_2_0.as
	Written by: Nicholas Bilyk

	LayoutManager_2_0(root_mc:MovieClip)
		Description: An abstract class extensible to Layout Managers.  
		root_mc: the root MovieClip where the objects to be positioned are.
	Functions:
		addObj(objToAdd:Object)
			Adds an object to the LayoutManager, objects in the layout manager will be positioned depending on the rules of the abstract draw method.
		removeObj(objToRemove):Boolean
			Removes object [objToRemove] from the Layout Manager.  (Linear search)
			Returns: true if the object was removed, or false if it was not found.
		addAll()
			Adds all objects on the root_mc that have a _width, _height, width, or a height  property. (does not need to be a movieclip.  So you could add a generic object with width=30, and height=20  and it would be like having an invisible MovieClip positioned in your layout.)

	Public Properties:
		leftMargin, rightMargin, topMargin, bottomMargin  
			Default: 5
			Sets the margins of the layout manager.   So for example, in FlowLayout, if you have a leftMargin of 50, and a rightMargin of 20, the objects placed will all start at 50 and wrap if they could exceed 20 from the right side. 
		height, width
			Default: width and height of [root_mc]

		
	Version: 0.01
*/
import nbilyk.utility.CoordMath;
import nbilyk.utility.ItemArray;

class nbilyk.gui.layoutManagers.LayoutManager implements nbilyk.interfaces.DrawInterface
{
	public var className:String = "LayoutManager";
	private var root_mc:MovieClip;
	private var objects_arr:ItemArray;
	private var _width:Number;
	private var _height:Number;
	private var _leftMargin:Number;
	private var _rightMargin:Number;
	private var _topMargin:Number;
	private var _bottomMargin:Number;
	private var hasDrawn:Boolean = false;
	private var validator_mc:MovieClip;

	public function LayoutManager(root_mc:MovieClip) {
		this.root_mc = root_mc;
		if (!_global.uniqueID) _global.uniqueID = 0;
		this.objects_arr = new ItemArray();
		// Defaults
		var defaultBounds = root_mc.getBounds(root_mc);
		this._width = (typeof(root_mc.width) == "number") ? root_mc.width : defaultBounds.xMax - defaultBounds.xMin; 
		this._height = (typeof(root_mc.height) == "number") ? root_mc.height : defaultBounds.yMax - defaultBounds.yMin; 
		this._leftMargin = 5;
		this._rightMargin = 5;
		this._topMargin = 5;
		this._bottomMargin = 5;
	}
	public function addObj(objToAdd:Object):Boolean {
		return this.addObjAt(objToAdd, this.objects_arr.length);
	}
	public function addObjAt(objToAdd:Object, index:Number):Boolean {
		if (objToAdd == this) return undefined;		
		if ((typeof(objToAdd._width) == "number" && typeof(objToAdd._height) == "number") || (typeof(objToAdd.width) == "number" && typeof(objToAdd.height) == "number")) {
			var success = this.objects_arr.removeItem(objToAdd);
			this.objects_arr.addItem(objToAdd, index);
			objToAdd.parentLayout = this;			
			this.invalidate();
			return true;
		} else {			
			return false;
		}
	}
	public function removeObj(objToRemove:Object):Boolean {
		var index:Number = this.objects_arr.removeItem(objToRemove);		
		if (index == undefined) {
			return false;
		} else {
			this.invalidate();
			return true;
		}
	}
	public function removeAllObjs() {
		this.objects_arr = new ItemArray();
		this.invalidate();
	}
	public function addAll(mc:MovieClip) {
		if (mc == undefined) { mc = this.root_mc; }
		var addArr = new Array();
		for (var all in mc) {
			addArr.unshift(mc[all]);			
		}
		var l = addArr.length;
		for (var i=0; i<l; i++) {	
			if (addArr[i]._name) this.addObj(addArr[i]);
		}
	}
	public function set leftMargin(newLeftMargin:Number) {
		if (!isNaN(newLeftMargin)) {
			this._leftMargin = newLeftMargin;
			this.invalidate();
		}
	}
	public function get leftMargin():Number { return this._leftMargin; }
	public function set rightMargin(newRightMargin:Number) {
		if (!isNaN(newRightMargin)) {
			this._rightMargin = newRightMargin;
			this.invalidate();
		}
	}
	public function get rightMargin():Number { return this._rightMargin; }

	public function set topMargin(newTopMargin:Number) {
		if (!isNaN(newTopMargin)) {
			this._topMargin = newTopMargin;
			this.invalidate();
		}
	}
	public function get topMargin():Number { return this._topMargin; }
	public function set bottomMargin(newBottomMargin:Number) {
		if (!isNaN(newBottomMargin)) {
			this._bottomMargin = newBottomMargin;
			this.invalidate();
		}
	}
	public function get bottomMargin():Number { return this._bottomMargin; }

	public function set height(newHeight:Number) {
		if (newHeight > 0) {
			this._height = newHeight;
			this.invalidate();
		}
	}
	public function get height():Number { return this._height; }
	public function set width(newWidth:Number) {
		if (newWidth > 0) {
			this._width = newWidth;
			this.invalidate();
		}
	}
	public function get width():Number { return this._width; }
	
	public function draw(){
		this.hasDrawn = true;
		this.validate();
	}	
	public function invalidate() {		
		var root_obj = this;
		if (!this.validator_mc) {
			this.validator_mc = this.root_mc.createEmptyMovieClip("validator_mc_"+(++_global.uniqueID), this.root_mc.getNextHighestDepth());			
			this.validator_mc.onEnterFrame = function() {
				if (root_obj.hasDrawn) root_obj.draw();
				this.removeMovieClip();
			}
		}
	}
	public function validate() {
		this.validator_mc.removeMovieClip();
		delete this.validator_mc;
	}
	public function setObj(itemNum:Number, new_obj:Object):Boolean {		
		if ((typeof(new_obj._width) == "number" && typeof(new_obj._height) == "number") || (typeof(new_obj.width) == "number" && typeof(new_obj.height) == "number")) {
			this.objects_arr[itemNum] = new_obj;
			return true;
		}
		return false;
	}
	public function getObj(itemNum:Number):Object {
		return this.objects_arr[itemNum];
	}
	public function get numItems():Number {
		var returnNum = this.objects_arr.length;
		while (returnNum && (this.objects_arr[returnNum-1] == undefined)) {
			returnNum--;
		}
		return returnNum;
	}
	public function get rightEdge():Number {
		// Inaccurate unless called after draw() has been invoked.
		var objectsL = this.objects_arr.length;
		var rightMostPoint = { x:Number.NEGATIVE_INFINITY, y:0 };
		for (var i=0; i<objectsL; i++) {
			var w = (typeof(this.objects_arr[i].width) == "number") ? this.objects_arr[i].width : this.objects_arr[i]._width;
			var currPoint = { x:(this.objects_arr[i]._x + w), y:this.objects_arr[i]._y };
			CoordMath.convertCoords(currPoint, this.objects_arr[i]._parent, this.root_mc);
			if (currPoint.x > rightMostPoint.x) {
				rightMostPoint = currPoint;
			}
		}
		return rightMostPoint.x;
	}
	public function get bottomEdge():Number {
		// Inaccurate unless called after draw() has been invoked.
		var objectsL = this.objects_arr.length;
		var lowestPoint = { x:0, y:Number.NEGATIVE_INFINITY };
		for (var i=0; i<objectsL; i++) {
			var h = (typeof(this.objects_arr[i].height) == "number") ? this.objects_arr[i].height : this.objects_arr[i]._height;
			var currPoint = { x:this.objects_arr[i]._x, y:(this.objects_arr[i]._y + h) };
			CoordMath.convertCoords(currPoint, this.objects_arr[i]._parent, this.root_mc);
			if (currPoint.y > lowestPoint.y) {
				lowestPoint = currPoint;
			}
		}
		return lowestPoint.y;
	}
};