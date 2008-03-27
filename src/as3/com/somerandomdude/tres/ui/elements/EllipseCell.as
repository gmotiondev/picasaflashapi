package com.somerandomdude.tres.ui.elements
{
	import flash.display.DisplayObject;
	import com.somerandomdude.tres.ui.elements.Cell;
	
	public class EllipseCell extends Cell
	{
		
		private var _rotation:Number;
		
		public function EllipseCell(x:Number=0, y:Number=0, rotation:Number=0, link:DisplayObject=null)
		{
			super(x, y, link);
			_rotation=rotation;
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			this._rotation=value;
		}
		
	}
}