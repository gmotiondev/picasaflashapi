import com.bourre.events.IEvent;

import flash.display.BitmapData;
import flash.geom.Matrix;

import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.Photo extends MovieClipHelper implements ILibListener
{
	private var id : String;
	private var url : String;
	private var loaded : Boolean = false;
	private var oef : MovieClip;
	private var proxy : String = "http://www.prasa.sk/image.php?image=";
	private var gl : GraphicLib;

	public function Photo(aName : String, aMC : MovieClip, aUrl : String)
	{
		super(aName, aMC);
		
		id = aName;
		url = aUrl;
	}

	private function enable() : Void
	{
		oef = view.createEmptyMovieClip("oef_mc", 6);
		
		var diag : Number = Math.sqrt(2 * Stage.width * Stage.width) * 0.62;
		var map : BitmapData = new BitmapData(Stage.width, Stage.height, true, 0x00000000);
		var mapHolder : MovieClip = view.createEmptyMovieClip("mapHolder", 10);
			mapHolder.attachBitmap(map, 10);
		
		var tMC : MovieClip = gl.getContent();
		var tImage : BitmapData = new BitmapData(tMC._width, tMC._height, false, 0xFFFFFF);
			tImage.draw(tMC);
		
		var tStamp : BitmapData = new BitmapData(tImage.width, tImage.height, false);
			tStamp.draw(tImage, new Matrix(0.5, 0, 0, 0.5, 0, 0), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(-0.5, 0, 0, 0.5, tImage.width, 0), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(0.5, 0, 0, -0.5, 0, tImage.height), null, "normal", null, true);
			tStamp.draw(tImage, new Matrix(-0.5, 0, 0, -0.5, tImage.width, tImage.height), null, "normal", null, true);
			
		tImage.dispose();

		var tSlice : MovieClip = view.createEmptyMovieClip("slice", 11);
			tSlice._visible = false;
			
		var slices : Number = 12;
		var angle = Math.PI / slices;
		var m : Matrix = new Matrix();
		
		oef.map = map;
		oef.onEnterFrame = function()
		{
			for (var i : Number = 0; i < slices; i++)
			{
				m.identity();
				m.translate(2 * _root._xmouse, 2 * _root._ymouse);

				tSlice.clear();
				tSlice.lineStyle();
				tSlice.moveTo(0, 0);
				tSlice.beginBitmapFill(tStamp, m);
				tSlice.lineTo(Math.cos(angle - Math.PI / 2) * diag, Math.sin(angle - Math.PI / 2) * diag);
				tSlice.lineTo(Math.cos(-angle - Math.PI / 2) * diag, Math.sin(-angle - Math.PI / 2) * diag);
				tSlice.lineTo(0, 0);
				tSlice.endFill();

				m.identity();
				m.rotate(i * angle * 2);
				m.translate(Stage.width / 2, Stage.height / 2);

				map.draw(tSlice, m, null, "normal", null, true);
			}
		};
		
		show();
	}

	private function disable() : Void
	{
		oef.map.dispose();
		oef.removeMovieClip();
		
		hide();
	}

	private function load() : Void
	{
		if(loaded) return;
		
		gl = new GraphicLib(view, 2);
		gl.setName(id);
		gl.addListener(this);
		gl.load(proxy + url);
	}

	public function onLoadInit(evt : LibEvent) : Void
	{
		loaded = true;
		
		enable();
	}

	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}

	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: " + evt.getName());
	}

	public function photo_changed_event(evt : IEvent) : Void
	{
		var tId : String = PhotoChangedEvent(evt).id;
		
		if(tId == id)
		{
			if(loaded) {
				enable();
			} else {
				load();
			}
		} else
		{
			if(isVisible()) disable();
		}
	}
}