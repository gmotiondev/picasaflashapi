/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import flash.display.BitmapData;
import flash.geom.Matrix;

import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.GraphicLibLocator;

import control.*;

class view.Photo extends MovieClipHelper implements ILibListener
{
	private var id:String;
	private var url:String;
	private var loaded:Boolean = false;
	private var oef:MovieClip;
	
	public function Photo(aId:String, aContainer:MovieClip, aUrl:String)
	{
		super(aId, aContainer);
		
		id = aId;
		url = aUrl;
		
		load();
	}
	
	private function enable():Void
	{
		oef = view.createEmptyMovieClip("oef_mc", 6);
		var diag:Number = Math.sqrt(2*Stage.width*Stage.width)*0.62;
		var map:BitmapData = new BitmapData(Stage.width, Stage.height, true, 0x00000000);
		var mapHolder:MovieClip = view.createEmptyMovieClip("mapHolder", 10);
		
		mapHolder.attachBitmap(map, 0);
		
		var tMC:MovieClip = GraphicLibLocator.getInstance().getGraphicLib(id).getContent();
		var tImage:BitmapData = new BitmapData(tMC._width, tMC._height, false, 0xFFFFFF);
			tImage.draw(tMC);
		
		var tStamp:BitmapData = new BitmapData(tImage.width, tImage.height, false);
			tStamp.draw(tImage, new Matrix(0.5, 0, 0, 0.5, 0, 0), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(-0.5, 0, 0, 0.5, tImage.width, 0), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(0.5, 0, 0, -0.5, 0, tImage.height), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(-0.5, 0, 0, -0.5, tImage.width, tImage.height), null, "normal", null, true);
			
		tImage.dispose();

		var tSlice:MovieClip = view.createEmptyMovieClip("slice", 11);
			tSlice._visible = false;
		var slices:Number = 12;
		var angle = Math.PI/slices;

		var m:Matrix = new Matrix();
		
		oef.map = map;
		oef.onEnterFrame = function()
		{
			for (var i = 0; i < slices; i++)
			{
				m.identity();
				m.translate(2*_root._xmouse, 2*_root._ymouse);

				tSlice.clear();
				tSlice.lineStyle();
				tSlice.moveTo(0, 0);
				tSlice.beginBitmapFill(tStamp, m);
				tSlice.lineTo(Math.cos(angle-Math.PI/2)*diag, Math.sin(angle-Math.PI/2)*diag);
				tSlice.lineTo(Math.cos(-angle-Math.PI/2)*diag, Math.sin(-angle-Math.PI/2)*diag);
				tSlice.lineTo(0, 0);
				tSlice.endFill();

				m.identity();
				m.rotate(i*angle*2);
				m.translate(Stage.width/2, Stage.height/2);

				map.draw(tSlice, m, null, "normal", null, true);
			}
		}
	}
	
	private function disable():Void
	{
		oef.map.dispose();
		oef.removeMovieClip();
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
			tLibStack.enqueue(new GraphicLib(view, 5), id, url);
			tLibStack.addListener(this);
			tLibStack.execute();
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
	}
	
	public function onTimeOut(evt:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		if(evt.id == id)
		{
			enable();
		} else
		{
			if(isVisible()) disable();
		}
	}
}