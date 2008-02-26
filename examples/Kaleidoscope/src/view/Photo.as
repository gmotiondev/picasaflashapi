/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import flash.display.BitmapData;
import flash.geom.Matrix;

import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.visual.ViewHelper;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.GraphicLibLocator;
import com.bourre.data.libs.OrphanGraphicLib;

import control.*;

class view.Photo extends MovieClipHelper implements ILibListener
{
	private var id:String;
	private var url:String;
	private var loaded:Boolean = false;
	
	public function Photo(aId:String, aContainer:MovieClip, aUrl:String)
	{
		super(aId, aContainer);
		
		id = aId;
		url = aUrl;
		
		load();
	}
	
	private function enable():Void
	{
		_quality = "BEST";
		var hsize = 500;
		var vsize = 500;
		var diag:Number = Math.sqrt(2*hsize*hsize)*0.62;
		var map:BitmapData = new BitmapData(hsize, vsize, true, 0x00000000);
		var mapHolder:MovieClip = view.createEmptyMovieClip("mapHolder", 10);
		var code:MovieClip;
		
		mapHolder.attachBitmap(map, 0);
		
		var tMC:MovieClip = GraphicLibLocator.getInstance().getGraphicLib(id).getContent();
		var image:BitmapData = new BitmapData(tMC._width, tMC._height, false, 0xFFFFFF);
			image.draw(tMC);
		
		trace("image: "+image);
			
		
		var stampImage:BitmapData = new BitmapData(image.width, image.height, false);
			stampImage.draw(image, new Matrix(0.5, 0, 0, 0.5, 0, 0), null, "normal", null, true);
			stampImage.draw(image, new Matrix(-0.5, 0, 0, 0.5, image.width, 0), null, "normal", null, true);
			stampImage.draw(image, new Matrix(0.5, 0, 0, -0.5, 0, image.height), null, "normal", null, true);
			stampImage.draw(image, new Matrix(-0.5, 0, 0, -0.5, image.width, image.height), null, "normal", null, true);
			
		image.dispose();
		
				
		var rotate1:Boolean = false;
		var rotate2:Boolean = false;
		var rotate3:Boolean = false;
		var flip:Boolean = true;
		var singleview:Boolean = true;
		var slice:MovieClip = view.createEmptyMovieClip("slice", 11);
			slice._visible = false;
		var slices:Number = 12;
		var angle = Math.PI/slices;
		var nudge = 0.009;
		var rotspeed1 = 0.007;
		var rotspeed2 = -0.003;
		var rotspeed3 = -0.005;
		var sclfact = 0;
		var rot:Number = 0;
		var r:Number = 0;
		var r2:Number = 0;
		var sh1:Number = 0;
		var sh2:Number = 0;
		var scl:Number = 1;
		var m:Matrix = new Matrix();
		
				
		view.onEnterFrame = function() {
			if (rotate1) {
				r += rotspeed1;
			}
			if (rotate2) {
				r2 -= rotspeed2;
			}
			if (rotate3) {
				rot += rotspeed3;
			}
			for (var i = 0; i<slices; i++) {
				m.identity();
				m.b += sh1;
				m.c += sh2;
				m.rotate(r2);
				m.translate(2*_root._xmouse/scl, 2*_root._ymouse/scl+i*sclfact*10);
				m.rotate(r);
				m.scale(scl, scl);
				slice.clear();
				slice.lineStyle();
				slice.moveTo(0, 0);
				slice.beginBitmapFill(stampImage, m);
				slice.lineTo(Math.cos((angle+nudge)-Math.PI/2)*diag, Math.sin((angle+nudge)-Math.PI/2)*diag);
				slice.lineTo(Math.cos(-(angle+nudge)-Math.PI/2)*diag, Math.sin(-(angle+nudge)-Math.PI/2)*diag);
				slice.lineTo(0, 0);
				slice.endFill();
				m.identity();
				if (flip && i%2 == 1) {
					m.scale(-1, 1);
				}
				m.rotate(rot+i*angle*2);
				m.translate(hsize*0.5, vsize*0.5);
				map.draw(slice, m, null, "normal", null, true);
			}
		}
	}
	
	private function disable():Void
	{
		
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
			tLibStack.enqueue(new GraphicLib(view, 5), id, url);
			tLibStack.addListener(this);
			tLibStack.execute();

//		var tGL:GraphicLib = new GraphicLib(view, 5);
//			tGL.setName(id);
//			tGL.addListener(this);
//			tGL.load(url);
	}
	
	public function onLoadInit(evt:LibEvent):Void
	{
		loaded = true;
	}
	
	public function onLoadProgress(evt:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt:LibEvent):Void
	{
//		var tGL:GraphicLib = GraphicLibLocator.getInstance().getGraphicLib(id);
//		trace(">> "+tGL.getContent());
		enable();
	}
	
	public function onTimeOut(evt:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		if(evt.id == id)
		{
			//enable();
		} else
		{
			if(isVisible()) disable();
		}
	}
}