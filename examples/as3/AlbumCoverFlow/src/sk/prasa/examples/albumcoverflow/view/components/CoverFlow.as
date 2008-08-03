package sk.prasa.examples.albumcoverflow.view.components 
{
	import flash.filters.GlowFilter;	
	import flash.filters.DropShadowFilter;	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import five3D.display.Bitmap3D;
	import five3D.display.Scene3D;
	import five3D.display.Shape3D;
	import five3D.display.Sprite3D;
	import five3D.utils.Drawing;
	
	import gs.TweenLite;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class CoverFlow extends Sprite 
	{
		public var ANGLE : Number = 65;			// plane angle
		public var SEPARATION : Number = 70;	// separation between bitmaps
		public var OFFSET : Number = 0;			// offset between selected and non-selected
		public var SELECTED_Z : Number = -280;	// z angle of the selected bitmap
		public var TIME : Number = 0.5;			// tween time
		
		private var __scene : Sprite3D;
		private var __current : int = 0;
		private var __list : Array;
		
		public function CoverFlow()
		{
			__scene = new Sprite3D();
			__scene.scaleX = 0.5;
			__scene.scaleY = 0.5;
			__scene.childrenSorted = true;
			__list = new Array();
			
			var tScene : Scene3D = new Scene3D();
				tScene.addChild(__scene);
				
			super.addChild(tScene);

			this.addEventListener(Event.ADDED_TO_STAGE, initializeWheel);
		}
		
		private function initializeWheel(evt : Event) : void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		override public function addChild(aChild : DisplayObject) : DisplayObject
		{
			var tChild : Sprite3D = aChild as Sprite3D;
			
			try
			{
				tChild = new Sprite3D();	
				tChild.addEventListener(MouseEvent.ROLL_OVER, onItemRollOver);
				tChild.addEventListener(MouseEvent.ROLL_OUT, onItemtRollOut);
				tChild.addEventListener(MouseEvent.CLICK, onClick);
				tChild.buttonMode = true;
				
				// because the original DisplayObject is never shown 
				// and we need the id of the focused DisplayObject
				tChild.name = aChild.name;
					
				var tBitmapData : BitmapData = new BitmapData(aChild.width, aChild.height, false, 0x000000);
					tBitmapData.draw(aChild);
				
				var tReflectionMatrix : Matrix = new Matrix(1, 0, 0, -1, 0, aChild.height);
				var tReflectionData : BitmapData = new BitmapData(aChild.width, aChild.height / 2, false, 0x000000);
					tReflectionData.draw(aChild, tReflectionMatrix);
					
				var tBitmap3D : Bitmap3D = new Bitmap3D(tBitmapData);
				tBitmap3D.filters = [new GlowFilter(0x000000, 1, 20, 20)];
				var tReflectionBitmap3D : Bitmap3D = new Bitmap3D(tReflectionData);
				
				var tReflectionMask : Shape3D = new Shape3D();
				Drawing.gradientHorizontalPlain(tReflectionMask.graphics3D, tReflectionData.width, 2 * tReflectionData.height, 0x000000, 0.8, 1, 15);
				tReflectionMask.scaleX = 0.5;
				tReflectionMask.scaleY = -1;
				tReflectionMask.rotationZ = 90;
				
				tChild.addChild(tBitmap3D);
				tChild.addChild(tReflectionBitmap3D);
				tChild.addChild(tReflectionMask);
									
				tBitmap3D.x = - tBitmapData.width / 2;
				tBitmap3D.y = - tBitmapData.height / 2;

				tReflectionBitmap3D.x = tReflectionMask.x = - tReflectionData.width / 2;
				tReflectionBitmap3D.y = tReflectionMask.y = tReflectionData.height;
				
				__scene.addChild(tChild);
				__list.push(tChild); // extra list because of z-sorting
				
				moveTo(__current);
				
			} catch(e : Error)
			{
				trace("CoverFlow Error: " + e);
			}
			
			return tChild;
		}
		
		public function removeChildByName(aName : String) : DisplayObject
		{
			try
			{
				return this.removeChild(__scene.getChildByName(aName));
				
			} catch(e : Error)
			{
				trace("CoverFlow, unable to remove child by name: " + e);
			}
			
			return null;
		}
		
		override public function removeChild(aChild : DisplayObject) : DisplayObject
		{
			var tChild : DisplayObject = aChild;
			
			try
			{
				tChild.removeEventListener(MouseEvent.ROLL_OVER, onItemRollOver);
				tChild.removeEventListener(MouseEvent.ROLL_OUT, onItemtRollOut);
				tChild.removeEventListener(MouseEvent.CLICK, onClick);

				tChild = __scene.removeChild(tChild);
				
				for(var a : int = 0; a < __list.length; a++)
				{
					if(__list[a] as Sprite3D == tChild)
					{
						__list.splice(a, 1);
						break;
					}
				}
				
			} catch(e : Error)
			{
				trace("CoverFlow, unable to remove child: " + e);
			}
			
			return tChild;
		}
		
		public function removeAll() : void
		{
			for(var a : int = __scene.numChildren - 1; a >= 0; a--)
			{
				this.removeChild(__scene.getChildAt(a));
			}
		}

		public function moveTo(aPos : int) : void
		{	
			for (var a : int = 0; a < __list.length; a++)
			{
				var tPlane : Sprite3D = __list[a] as Sprite3D;
				var tDis : int = getIndexDuration(aPos, a);
				var tTargetZ : Number = tDis * 50;
				
				if (a == aPos)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: 0,
						z			: SELECTED_Z + tTargetZ,
//						alpha       :1,
						rotationY	: 0
					});
					
				} else if (a < aPos)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: (aPos - a + 1) * -SEPARATION - OFFSET,
						z			: 0 + tTargetZ,
//						alpha       :1 - tDis/10, 
						rotationY	: -ANGLE  
					});
					
				} else
				{					
					TweenLite.to(tPlane, TIME,
					{
						x			: ((a - aPos + 1) * SEPARATION) + OFFSET,
						z			: 0 + tTargetZ,
//						alpha       :1 - tDis/10, 
						rotationY	: ANGLE
					});
				}
			}

			__current = aPos;
		}
		
		private function onItemRollOver(evt : MouseEvent) : void
		{
		}

		private function onItemtRollOut(evt : MouseEvent) : void
		{
		}
		
		private function onClick(evt : MouseEvent) : void
		{				
			for(var a : int = 0; a < __list.length; a++)
			{
				if(__list[a] as Sprite3D == evt.currentTarget)
				{
					moveTo(a);
					break;
				}
			}
		}
		
		private function onMouseWheel(evt : MouseEvent) : void
		{
			if (evt.delta < 0)
			{
				if (__current < __list.length - 1)
				{ 
					moveTo(__current + 1);
				}
			} else
			{	
				if (__current > 0) 
				{ 
					moveTo(__current - 1); 
				}
			}
		}

		private function getIndexDuration(aCenterID : int, aCurrentID : int) : int
		{
			return Math.abs(aCenterID - aCurrentID);
		}
	}
}
