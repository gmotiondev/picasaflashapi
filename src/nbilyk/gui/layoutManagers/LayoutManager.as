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
	private var parent:MovieClip;
	private var objects_arr:ItemArray;
	private var _width:Number;
	private var _height:Number;
	private var __l, __r, __t, __b:Number;

	private var hasDrawn:Boolean = false;
	//private var validator_mc:MovieClip;

	public function LayoutManager(aMc:MovieClip)
	{
		parent = aMc;
		//if (!_global.uniqueID) _global.uniqueID = 0;
		objects_arr = new ItemArray();
		// Defaults
		var tDB = parent.getBounds(parent);
		
		_width = (typeof(parent.width) == "number") ? parent.width : tDB.xMax - tDB.xMin;
		_height = (typeof(parent.height) == "number") ? parent.height : tDB.yMax - tDB.yMin;
		
		__l = 5;
		__r = 5;
		__t = 5;
		__b = 5;
	}
	public function addObj(o:Object):Boolean {
		return addObjAt(o, objects_arr.length);
	}
	public function addObjAt(o:Object, i:Number):Boolean
	{
		if ((typeof(o._width) == "number" && typeof(o._height) == "number") || (typeof(o.width) == "number" && typeof(o.height) == "number")) {
			//var success = this.objects_arr.removeItem(objToAdd);
			objects_arr.addItem(o, i);
			//o.parentLayout = this;
			invalidate();
			return true;
		} else {
			return false;
		}
	}
	public function removeObj(o:Object):Boolean
	{
		var i:Number = objects_arr.removeItem(o);		
		if (i == undefined) {
			return false;
		} else {
			invalidate();
			return true;
		}
	}
	public function removeAllObjs()
	{
		objects_arr = new ItemArray();
		invalidate();
	}
	
	public function addAll(aMC:MovieClip)
	{
		var tArr:Array = [];
		var tMC:MovieClip = (aMC != undefined) ? aMC : parent;
		
		for (var tKey:String in tMC) {
			tArr.unshift(tMC[tKey]);			
		}

		for (var a = 0; a < tArr.length; a++) {	
			if (tArr[a]._name) {
				this.addObj(tArr[a]);
			}
		}
	}
	
	public function set leftMargin(a:Number):Void
	{
		__l = a;
		invalidate();
	}
	public function get leftMargin():Number
	{
		return __l;
	}
	
	public function set rightMargin(a:Number):Void
	{
		__r = a;
		invalidate();
	}
	
	public function get rightMargin():Number
	{
		return __r;
	}

	public function set topMargin(a:Number):Void
	{
		__t = a;
		invalidate();
	}
	public function get topMargin():Number
	{
		return __t;
	}
	
	public function set bottomMargin(a:Number):Void
	{
		__b = a;
		invalidate();
	}
	
	public function get bottomMargin():Number
	{
		return __b;
	}

	public function set height(a:Number):Void
	{
		_height = a;
		invalidate();
	}
	
	public function get height():Number
	{
		return _height;
	}
	
	public function set width(a:Number):Void
	{
		_width = a;
		invalidate();
	}
	
	public function get width():Number
	{
		return _width;
	}
	
	public function draw():Void
	{
		hasDrawn = true;
		validate();
	}
	
	public function invalidate():Void
	{
//		if (!validator_mc)
//		{
//			validator_mc.ref = this;
//			validator_mc = parent.createEmptyMovieClip("validator_mc_"+(++_global.uniqueID), parent.getNextHighestDepth());
//			validator_mc.onEnterFrame = function()
//			{
//				if (this.ref.hasDrawn) this.ref.draw();
				if (hasDrawn) draw();
//				this.removeMovieClip();
//			}
//		}
	}
	public function validate()
	{
//		validator_mc.removeMovieClip();
//		delete validator_mc;
	}
	public function setObj(a:Number, o:Object):Boolean
	{
		if ((typeof(o._width) == "number" && typeof(o._height) == "number") || (typeof(o.width) == "number" && typeof(o.height) == "number")) {
			objects_arr[a] = o;
			return true;
		}
		return false;
	}
	public function getObj(a:Number):Object
	{
		return objects_arr[a];
	}
	public function get numItems():Number {
		var tNum = objects_arr.length;
		while (tNum && (objects_arr[tNum - 1] == undefined))
		{
			tNum--;
		}
		return tNum;
	}
	public function get rightEdge():Number
	{
		// Inaccurate unless called after draw() has been invoked.
		var tR = {x:Number.NEGATIVE_INFINITY, y:0};
		for (var i = 0; i < objects_arr.length; i++)
		{
			var tW = (typeof(objects_arr[i].width) == "number") ? objects_arr[i].width : objects_arr[i]._width;
			var tCur = { x:(objects_arr[i]._x + tW), y:objects_arr[i]._y };
			//CoordMath.convertCoords(tCur, objects_arr[i]._parent, parent);
			if (tCur.x > tR.x)
			{
				tR = tCur;
			}
		}
		return tR.x;
	}
	public function get bottomEdge():Number
	{
		// Inaccurate unless called after draw() has been invoked.
		var tL = {x:0, y:Number.NEGATIVE_INFINITY};
		for (var i = 0; i < objects_arr.length; i++)
		{
			var tH = (typeof(this.objects_arr[i].height) == "number") ? this.objects_arr[i].height : this.objects_arr[i]._height;
			var tCur = { x:this.objects_arr[i]._x, y:(this.objects_arr[i]._y + tH) };
			//CoordMath.convertCoords(tCur, this.objects_arr[i]._parent, parent);
			if (tCur.y > tL.y) {
				tL = tCur;
			}
		}
		return tL.y;
	}
};