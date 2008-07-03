package sk.prasa.examples.albumcoverflow.view.components 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import five3D.display.Bitmap3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	
	import gs.TweenLite;		
	
	/**
	 * Thumbs view.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class ThumbsView extends Sprite 
	{
		private var __rootNode : Sprite3D;
		private var __array : Array = new Array();
		private var __dict : Dictionary = new Dictionary();
		
		private var __current : Number = 0;
		public static var ANGLE : Number = 65;			// plane angle
		public static var SEPARATION : Number = 100;	// separation between bitmaps
		public static var OFFSET : Number = 160;		// offset between selected and non-selected
		public static var SELECTED_Z : Number = -280;	// z angle of the selected bitmap
		public static var TIME : Number = 0.5;			// tween time
		
		
		public function ThumbsView()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initialize3D);
		}
		
		private function initialize3D(evt : Event) : void
		{
			__rootNode = new Sprite3D();
			__rootNode.scaleX = .5;
			__rootNode.scaleY = .5;
			
			var tScene : Scene3D = new Scene3D();
				tScene.addChild(__rootNode);
				
			trace("tScene.distance: " + tScene.viewDistance);
			
			this.addChild(tScene);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onEventMouseWheel);
		}
		
		override public function addChild(aChild : DisplayObject) : DisplayObject
		{
			// can be also other types of childs added!
			if(aChild is ThumbView)
			{
				var tPlane : Sprite3D = new Sprite3D();	
					tPlane.addEventListener(MouseEvent.ROLL_OVER, onEventRollOver);
					tPlane.addEventListener(MouseEvent.ROLL_OUT, onEventRollOut);
					tPlane.addEventListener(MouseEvent.CLICK, onClick);
					tPlane.buttonMode = true;
					
				var tBitmapData : BitmapData = new BitmapData(aChild.width, aChild.height, false, 0x000000);
					tBitmapData.draw(aChild);
					
				var tBitmap3D : Bitmap3D = new Bitmap3D(tBitmapData);

				tPlane.addChild(tBitmap3D);
				tBitmap3D.x = -tBitmapData.width/2;
				tBitmap3D.y = -tBitmapData.height/2;
				__rootNode.addChild(tPlane);
				
				__array.push(tPlane);
				__dict[tPlane] = __array.length;
				
				// don't show this instance on main screen
				return null;
			}
			
			// else if other type of child, show it on main screen
			return super.addChild(aChild);
		}

		private function onEventRollOver(evt : MouseEvent) : void
		{
		}

		private function onEventRollOut(evt : MouseEvent) : void
		{
		}
		
		private function onClick(evt : MouseEvent) : void
		{
			shiftToItem(__dict[evt.currentTarget] - 1);
		}
		
		private function onEventMouseWheel(evt : MouseEvent) : void
		{
			if (evt.delta < 0)
			{
				moveRight();
			} else
			{	
				moveLeft();
			}
		}

		public function moveLeft() : void
		{
			if (__current > 0)
			{
				shiftToItem(__current - 1);
			}
		}

		public function moveRight() : void 
		{
			if (__current < __array.length -1)
			{
				shiftToItem(__current + 1);
			}
		}

		private function getIndexDuration(aCenterID : Number, aCurrentID : Number) : Number
		{
			return Math.abs(aCenterID - aCurrentID);
		}
		
		public function shiftToItem(newCenterPlaneIndex : Number) : void
		{
			var tRest : int = 0;
			 
			if (__current == newCenterPlaneIndex) return;

			for (var i : int = 0; i < __array.length; i++)
			{
				var tPlane : Sprite3D = __array[i] as Sprite3D;
					tPlane.parent.setChildIndex(tPlane, i);
				var tDis : int = getIndexDuration(newCenterPlaneIndex, i);
				var tTargetZ : Number = tDis * 50;
				
				if (i == newCenterPlaneIndex)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: 0,
						z			: SELECTED_Z + tTargetZ,
						rotationY	: 0
					});
				} else if (i < newCenterPlaneIndex)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: (newCenterPlaneIndex - i + 1) * -SEPARATION - OFFSET,
						z			: 0 + tTargetZ,
						rotationY	: -ANGLE  
					});
				} else
				{
					var tSwap : int = __array.length - 1 - tRest;
					if(i < tSwap)
					{
					//	trace("swapping: " + i + " vs. " + tSwap);
						tPlane.parent.swapChildrenAt(i, tSwap);
					}
					
//					trace("(" + tL+ "/" + __array.length + "), depth current: " + tPlane.parent.getChildIndex(tPlane) + ", should be: " + (tL + i + tRest) + ", rest is: " + tRest);
					 
					
					//tPlane.parent.setChildIndex(tPlane, i + (tRest));
					tRest++;
					
					TweenLite.to(tPlane, TIME,
					{
						x			: ((i-newCenterPlaneIndex + 1) * SEPARATION) + OFFSET,
						z			: 0 + tTargetZ,
						rotationY	: ANGLE
//						alpha		: 1 - tDis/10
					});
				}
			}

			__current = newCenterPlaneIndex;
		}
	}
}
