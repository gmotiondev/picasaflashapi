package sk.prasa.examples.albumcoverflow.view.components 
{
	import flash.display.Loader;	
	import flash.display.DisplayObject;	
	import flash.display.BitmapData;	
	
	import five3D.display.Bitmap3D;	
	
	import gs.TweenLite;	
	
	import flash.events.Event;	
	import flash.utils.Dictionary;	
	import flash.text.TextField;	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import five3D.display.DynamicText3D;
	import five3D.display.Scene3D;
	import five3D.display.Shape3D;
	import five3D.display.Sprite3D;
	import five3D.typography.HelveticaBold;
	import five3D.utils.Drawing;
	/**
	 * Thumbs view. In general it's a flow-layout container.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class ThumbsView extends Sprite 
	{
		private var __rootNode : Sprite3D;
		private var __indexMax : int = 0;
		
		private var __array : Array = new Array();
		private var __dict : Dictionary = new Dictionary();
		
		private var currentPlaneIndex : Number = 0;
		private var planeAngle : Number = 65;
		private var planeSeparation : Number = 105;
		private var planeOffset : Number = 120;
		private var selectPlaneZ : Number = -280;
		private var tweenTime : Number = 0.8;
		private var transition : String = "easeOutExpo"; 
		//"easeOutSine";
		private var textTitle : TextField = null;
		private var currentIndex : Number = 0;
		private var needsRender : Boolean = true;
		
		private var index : int = 0;
		
		

		//private var loader:LoaderX = new LoaderX();
		
		public function ThumbsView()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initialize3D);
		}
		
		private function initialize3D(evt : Event) : void
		{
			var tScene : Scene3D = new Scene3D();
				tScene.x = this.stage.stageWidth / 2;
				tScene.y = this.stage.stageHeight / 2;
				
			this.addChild(tScene);
			
			__rootNode = new Sprite3D();
			__rootNode.scaleX = .5;
			__rootNode.scaleY = .5;
			
			tScene.addChild(__rootNode);

			//var _ref:BitmapData = BitmapUtil.getReflection(shadow_mc);
			for (var i : int = 0; i < __indexMax; i++ )
			{
				var tPlane : Sprite3D = new Sprite3D();
					tPlane.graphics3D.beginFill(0x222222);
					tPlane.graphics3D.drawRoundRect(-150, -150, 150, 150, 40, 40);
					tPlane.graphics3D.endFill();
					tPlane.addEventListener(MouseEvent.ROLL_OVER, onEventRollOver);
					tPlane.addEventListener(MouseEvent.ROLL_OUT, onEventRollOut);
					tPlane.addEventListener(MouseEvent.CLICK, onClick);
					tPlane.buttonMode = true;

				__rootNode.addChild(tPlane);
				__array.push(tPlane);
				__dict[tPlane] = i;

//				var tText : DynamicText3D = new DynamicText3D(HelveticaBold);
//					tText.size = 60;
//					tText.color = 0xffffff;
//					tText.text = "." + i;
//					tText.x = -100;
//					tText.name = "txt";
//
//				tPlane.addChild(tText);

//				var tShape : Shape3D = new Shape3D();
//					tShape.name = "star";
//					tShape.x = -120;
//					tShape.y = -120;
//				
//				Drawing.star(tShape.graphics3D, 10, 14, 8, 0, 16777215);
//				tPlane.addChild(tShape);

//				var tRef : Shape3D = new Shape3D();
//					tRef.x -= 150;
//					tRef.y = 150;
//				
//				Drawing.gradientHorizontalPlain(tRef.graphics3D, 300, 200, 0x000000, 0.4, 0, 15);
//				
//				tPlane.addChild(tRef);
				
				/*
				var _bmp3D:Bitmap3D = new Bitmap3D(_ref);
				_bmp3D.x -= 150;
				_bmp3D.y = 150;
				*/
				//p.addChild(_bmp3D);
			}

			shiftToItem(5);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onEventMouseWheel);

			//loadNextIMG();
			/*
			var spr2d:Sprite2D = new Spr();
			spr2d.x = 30
			spr2d.z = 100
			rootNode.addChild(spr2d);
			var bmp:BitmapData = new JPG(0, 0);
			bmp3d = new Bitmap3D(bmp,true,8,8);
			scene.addChild(bmp3d);*/
		}
		
		override public function addChild(aChild : DisplayObject) : DisplayObject
		{
			//var tChild : DisplayObject = super.addChild(aChild);
			
			if(aChild is ThumbView)
			{
				var tPlane : Sprite3D = new Sprite3D();	
				var tBitmapData : BitmapData = new BitmapData(320, 320);
					tBitmapData.draw(aChild);
					
				//trace("tChild: " + tChild + "(" + tChild.width + ", " + tChild.height + ")");
				var tBitmap3D : Bitmap3D = new Bitmap3D(tBitmapData);
				tPlane.addChild(tBitmap3D);
				__rootNode.addChild(tPlane);
				
				__array.push(tPlane);
				__dict[tPlane] = __array.length;
				
				return null;
			}
			
			return super.addChild(aChild);
		}

		private function onEventRollOver(evt : MouseEvent) : void
		{
//			var _spr : Sprite3D = evt.currentTarget as Sprite3D;
//			var _str : Shape3D = _spr.getChildByName("star") as Shape3D;
//			var _txt : DynamicText3D = _spr.getChildByName("txt") as DynamicText3D;
			
//			TweenLite.to(_str, 1, {rotationZ : _str.rotationZ+90});
//			TweenLite.to(_txt, 1, {x : 50} );
		}

		private function onEventRollOut(evt : MouseEvent) : void
		{
//			var _spr : Sprite3D = evt.currentTarget as Sprite3D;
//			var _txt : DynamicText3D = _spr.getChildByName("txt") as DynamicText3D;

//			TweenLite.to(_txt, 1, {x:-100});
		}
		
		private function onClick(evt : MouseEvent) : void
		{
			shiftToItem(__dict[evt.currentTarget]);
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
			if (currentPlaneIndex > 0)
			{
				shiftToItem(currentPlaneIndex - 1);
			}
		}

		public function moveRight() : void 
		{
			if (currentPlaneIndex < __array.length -1)
			{
				shiftToItem(currentPlaneIndex+1);
			}
		}

		private function getIndexDuration(aCenterID : Number, aCurrentID : Number) : Number
		{
			return Math.abs(aCenterID -aCurrentID);
		}
		
		public function shiftToItem(newCenterPlaneIndex : Number) : void
		{
			if (currentPlaneIndex == newCenterPlaneIndex) return;

			for (var i : int = 0; i < __array.length; i++)
			{
				var tPlane : Sprite3D = __array[i] as Sprite3D;
				var tDis : int = getIndexDuration(newCenterPlaneIndex, i);
				var tTargetZ : Number = tDis * 50;

				//plane.transform.colorTransform = new ColorTransform(_targetZ, _targetZ, _targetZ, 1);
				if (i == newCenterPlaneIndex)
				{
					TweenLite.to(tPlane, tweenTime,
					{
						x			: 0,
						z			: selectPlaneZ + tTargetZ,
						rotationY	: 0,
						alpha		:1,
						//transition	:transition,
						onComplete	: function() : void { needsRender = false;} 
					});
				} else if (i < newCenterPlaneIndex)
				{
					TweenLite.to(tPlane, tweenTime,
					{
						x			: (newCenterPlaneIndex - i+1) * -planeSeparation - planeOffset,
						z			: 0 + tTargetZ,
						rotationY	: -planeAngle,
						//transition	:transition,
						alpha		:1 - tDis / 10					
					});
				} else
				{
					TweenLite.to(tPlane, tweenTime,
					{
						x			: ((i-newCenterPlaneIndex+1) * planeSeparation) + planeOffset,
						z			: 0 + tTargetZ,
						rotationY	: planeAngle,
						//transition	:transition,
						alpha		:1 - tDis/10
					});
				}
			}

			currentPlaneIndex = newCenterPlaneIndex;
		}
	}
}
