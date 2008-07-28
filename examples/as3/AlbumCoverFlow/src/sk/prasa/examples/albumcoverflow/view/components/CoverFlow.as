package sk.prasa.examples.albumcoverflow.view.components 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import five3D.display.Bitmap3D;
	import five3D.display.Scene3D;
	import five3D.display.Sprite3D;
	
	import gs.TweenLite;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class CoverFlow extends Sprite 
	{
		public var ANGLE : Number = 65;			// plane angle
		public var SEPARATION : Number = 100;	// separation between bitmaps
		public var OFFSET : Number = 160;		// offset between selected and non-selected
		public var SELECTED_Z : Number = -280;	// z angle of the selected bitmap
		public var TIME : Number = 0.5;			// tween time
		
		private var __scene : Sprite3D;
		private var __current : int = 0;
		private var __children : Array;

		public function CoverFlow()
		{
			__scene = new Sprite3D();
			__scene.scaleX = 0.5;
			__scene.scaleY = 0.5;
			__children = new Array();
			
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
			try
			{
				var tPlane : Sprite3D = new Sprite3D();	
					tPlane.addEventListener(MouseEvent.ROLL_OVER, onItemRollOver);
					tPlane.addEventListener(MouseEvent.ROLL_OUT, onItemtRollOut);
					tPlane.addEventListener(MouseEvent.CLICK, onClick);
					tPlane.buttonMode = true;
					
				var tBitmapData : BitmapData = new BitmapData(aChild.width, aChild.height, false, 0x000000);
					tBitmapData.draw(aChild);
					
				var tBitmap3D : Bitmap3D = new Bitmap3D(tBitmapData);
					tPlane.addChild(tBitmap3D);
					tBitmap3D.x = - tBitmapData.width/2;
					tBitmap3D.y = - tBitmapData.height/2;
				
				__scene.addChild(tPlane);
				__children.push(tPlane);
				
				// reposition and reindex
				moveTo(__current);
				reindex(__current - 1);
				
			} catch(e : Error)
			{
				trace("CoverFlow Error: " + e);
			}
			
			// else if other type of child, show it on main screen
			return aChild;
		}
		
		override public function removeChild(aChild : DisplayObject) : DisplayObject
		{
			try
			{
				var tIndex : int = __scene.getChildIndex(aChild);
				var tChild : DisplayObject = __scene.removeChild(aChild);
				
				__children.slice(tIndex, 1);
				
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

		public function moveTo(aPos : int, aTweenWait : Boolean = false) : void
		{	
			for (var a : int = 0; a < __children.length; a++)
			{
				var tPlane : Sprite3D = __children[a] as Sprite3D;
				var tDis : int = getIndexDuration(aPos, a);
				var tTargetZ : Number = tDis * 50;
				
				if (a == aPos)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: 0,
						z			: SELECTED_Z + tTargetZ,
						rotationY	: 0
					});
					
				} else if (a < aPos)
				{
					TweenLite.to(tPlane, TIME,
					{
						x			: (aPos - a + 1) * -SEPARATION - OFFSET,
						z			: 0 + tTargetZ,
						rotationY	: -ANGLE  
					});
					
				} else
				{					
					TweenLite.to(tPlane, TIME,
					{
						x			: ((a - aPos + 1) * SEPARATION) + OFFSET,
						z			: 0 + tTargetZ,
						rotationY	: ANGLE
					});
				}
				
				reindex(aPos, aTweenWait);
			}

			__current = aPos;
		}
		
		private function reindex(aPos : int, aTweenWait : Boolean = false) : void
		{
			var tRest : int = __children.length - 1;
			
			for (var a : int = 0; a < __children.length; a++)
			{
				var tPlane : Sprite3D = __children[a] as Sprite3D;
	
				if (a == aPos)
				{
					
				} else if (a < aPos)
				{
					tPlane.parent.setChildIndex(tPlane, a);
					
				} else
				{
					if(!aTweenWait)
					{				
						tPlane.parent.setChildIndex(tPlane, tRest);
					}
										
					tRest--;
				}
			}
		}
		
		private function onItemRollOver(evt : MouseEvent) : void
		{
			evt.stopImmediatePropagation();
			dispatchEvent(evt);
		}

		private function onItemtRollOut(evt : MouseEvent) : void
		{
			evt.stopImmediatePropagation();
			dispatchEvent(evt);
		}
		
		private function onClick(evt : MouseEvent) : void
		{
			for(var a : int = 0; a < __children.length; a++)
			{
				if(__children[a] as Sprite3D == evt.currentTarget)
				{
					moveTo(a, __current < a);
					break;
				}
			}
		}
		
		private function onMouseWheel(evt : MouseEvent) : void
		{
			if (evt.delta < 0)
			{
				if (__current < __children.length - 1)
				{ 
					moveTo(__current + 1, true);
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
