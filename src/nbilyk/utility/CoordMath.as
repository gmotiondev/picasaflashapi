/*-------------------------------------------------------------------
	Written by: Nicholas Bilyk
	CoordMath()
		Description: 
	Functions: 

	Version: 1
-------------------------------------------------------------------*/
//import flash.geom.Point;
import com.bourre.structures.Point;

class nbilyk.utility.CoordMath {	
	private static function checkArgs(point:Object, mc1:MovieClip, mc2:MovieClip) {
		if (point == undefined) point = new Object();
		if (point.x == undefined) point.x = 0;
		if (point.y == undefined) point.y = 0;
	}
	public static function convertCoords (point:Object, from_mc:MovieClip, to_mc:MovieClip) {
		CoordMath.checkArgs(point, from_mc, to_mc);		
		if (!from_mc || !to_mc)	return point;
		from_mc.localToGlobal(point);
		to_mc.globalToLocal(point);
	}
	public static function convertDistance (distance:Object, from_mc:MovieClip, to_mc:MovieClip) {
		CoordMath.checkArgs(distance, from_mc, to_mc);		
		if (!from_mc || !to_mc)	return undefined;

		var topLeft = { x:0, y:0 };		
		CoordMath.convertCoords(topLeft, from_mc, to_mc);
		CoordMath.convertCoords(distance, from_mc, to_mc);
		distance.x -= topLeft.x;
		distance.y -= topLeft.y;		
	}
	public static function convertDimensions (from_mc:MovieClip, to_mc:MovieClip) {
		var boundsObj = from_mc.getBounds(from_mc);
		var bottomRight = new Object();
		bottomRight.x = boundsObj.xMax - boundsObj.xMin;
		bottomRight.y = boundsObj.yMax - boundsObj.yMin;
		CoordMath.convertDistance(bottomRight, from_mc, to_mc);
		var newDimensions = new Object();
		newDimensions.width = bottomRight.x;
		newDimensions.height = bottomRight.y;
		return newDimensions;
	}
	
	public static function moveWithinContainer (x:Number, y:Number, small_mc:MovieClip, large_mc:MovieClip) {
		/* 
			calculatePos  written by Nicholas Bilyk
			description: This function will return a point that ensures that the small_mc is completely contained within the large_mc given an attempted translation of small_mc (x, y) pixels.
			arguments: 
				x: pixels small_mc is moving horizontally.
				y: pixels small_mc is moving vertically.
				small_mc: the smaller movieclip that must always be inside of the larger movieclip.
				large_mc: the larger movieclip that must always contain the smaller movieclip.
		 
		*/
		
		// First convert x, y, width, and height values of the small_mc to be in the scope of the large_mc.		
		if (x == undefined) {
			x = 0;
		}
		if (y == undefined) {
			y = 0;
		}
		var topLeft = { x:(small_mc._x + x), y:(small_mc._y + y) };
		CoordMath.convertCoords(topLeft, small_mc._parent, large_mc);
		var sDims = CoordMath.convertDimensions(small_mc, large_mc);
		var lDims = large_mc.getBounds(large_mc);

		if (topLeft.x < lDims.xMin) {
			// too far left.
			topLeft.x = lDims.xMin;
		}
		if (topLeft.y < lDims.yMin) {
			// too far up.
			topLeft.y = lDims.yMin;
		}
		if (topLeft.x + sDims.width > lDims.xMax) {
			// too far right.
			topLeft.x = lDims.xMax - sDims.width;
		}
		if (topLeft.y + sDims.height > lDims.yMax) {
			// too far down.
			topLeft.y = lDims.yMax - sDims.height;
		}
		// Converts the coordinates back to the scope of small_mc's parent.
		CoordMath.convertCoords(topLeft, large_mc, small_mc._parent);
		return topLeft;		
	}
	public static function getCorners(root_mc:MovieClip, target_mc):Object
	{
		var topLeft, topRight, bottomRight, bottomLeft:Object;
		var bounds_obj:Object;
		
		if (target_mc == undefined) target_mc = root_mc;
		if (typeof(target_mc) == "movieclip") {
			bounds_obj = target_mc.getBounds(target_mc);
			topLeft = { x:bounds_obj.xMin, y:bounds_obj.yMin };
			topRight = { x:bounds_obj.xMax, y:bounds_obj.yMin };
			bottomRight = { x:bounds_obj.xMax, y:bounds_obj.yMax };
			bottomLeft = { x:bounds_obj.xMin, y:bounds_obj.yMax };
			CoordMath.convertCoords(topLeft, target_mc, root_mc);
			CoordMath.convertCoords(topRight, target_mc, root_mc);
			CoordMath.convertCoords(bottomRight, target_mc, root_mc);
			CoordMath.convertCoords(bottomLeft, target_mc, root_mc);
		} else {
			bounds_obj = { xMin:target_mc._x, yMin:target_mc._y, xMax:target_mc._x+target_mc._width, yMax:target_mc._y+target_mc._height };
			topLeft = { x:bounds_obj.xMin, y:bounds_obj.yMin };
			topRight = { x:bounds_obj.xMax, y:bounds_obj.yMin };
			bottomRight = { x:bounds_obj.xMax, y:bounds_obj.yMax };
			bottomLeft = { x:bounds_obj.xMin, y:bounds_obj.yMax };
		}
		return { topLeft:topLeft, topRight:topRight, bottomRight:bottomRight, bottomLeft:bottomLeft };
	}
	public static function getDistance(point1:Object, point2:Object):Number {
		return Point.getDistance(new Point(point1.x, point1.y), new Point(point2.x, point2.y));
	}
}