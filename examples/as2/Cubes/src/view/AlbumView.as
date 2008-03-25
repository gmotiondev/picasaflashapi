import flash.display.BitmapData;

import org.papervision3d.cameras.Camera3D;
import org.papervision3d.materials.BitmapMaterial;
import org.papervision3d.scenes.MovieScene3D;

import com.bourre.commands.Delegate;
import com.bourre.data.libs.*;
import com.bourre.events.IEvent;
import com.bourre.structures.Point;
import com.bourre.visual.MovieClipHelper;

import control.*;

import gs.TweenLite;

import sk.prasa.visual.layout.OGrid;

import view.object.PhotoThumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.AlbumView extends MovieClipHelper implements ILibListener
{
	public var container :MovieClip;
	public var scene : MovieScene3D;
	public var camera : Camera3D;
	public var radius : Number = 3000;
	public var grid : OGrid;

	private var pos : Number = 0;
	private var open : Boolean = false;

	public function AlbumView(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		initialize();
	}
	
	public function setupGrid(aChildLength : Number) : Void
	{
		var tSide : Number = Math.ceil( Math.sqrt( aChildLength ) );
			grid = new OGrid(tSide, tSide);
	}
	
	public function getChildContainer(aId : String) : MovieClip
	{
		var tC : MovieClip = view.createEmptyMovieClip("t_"+aId, view.getNextHighestDepth());
		
		return tC;
	}
	
	private function initialize() : Void
	{	
		view.onEnterFrame = Delegate.create(this, loop);
		
		container = view.createEmptyMovieClip( "container", view.getNextHighestDepth() );
		container._x = 240;
		container._y = 180;
	
		scene = new MovieScene3D( container );

		camera = new Camera3D();
		camera.z = -1500;
		camera.zoom = 1;
		camera.focus = 1500;
	}

	private function loop() : Void
	{	
//		if(!open)
//		{
			TweenLite.to(camera, 0, {
				x : container._xmouse * 1.5,
				y : container._ymouse * 1.5
				});
			 
//		} else
//		{
//			camera.x = 0;
//			camera.y = 0;
//		}
		
		scene.renderCamera( camera );
	}
		
	public function onLoadInit(evt : LibEvent) : Void
	{
		var tMC : MovieClip = evt.getTarget().getContent();
		var tImage : BitmapData = new BitmapData(tMC._width, tMC._height, false, 0xCCCCCC);
			tImage.draw(tMC);
		
		tMC.removeMovieClip();

		var tPos : Point = grid.getCoordinates(pos++);
		var tXYZ : Object = {
			x : (tPos.x * radius / 15),
			y : (tPos.y * radius / 15),
			z : 100
			};
		
		var tMaterial : BitmapMaterial = new BitmapMaterial(tImage);
			tMaterial.oneSide = false;
		
		var tThumb : PhotoThumb = new PhotoThumb(tMaterial, tImage.width, tImage.height);
			tThumb.x = tXYZ.x; tThumb.y = tXYZ.y; tThumb.z = tXYZ.z;

		scene.push(tThumb);	
		addListener(tThumb);
		
		tThumb.activate(evt.getName(), getName());
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		//EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		// libstack is complete!
	}

	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}

	public function notifyChanged(evt : IEvent) : Void
	{
		_oEB.broadcastEvent( evt );
	}
	
	public function photo_open_event(evt : PhotoOpenEvent) : Void
	{
		open = true;
		notifyChanged(evt);
	}
	
	public function photo_close_event(evt : PhotoCloseEvent) : Void
	{
		open = false;
		notifyChanged(evt);
	}
	
	public function album_open_event(evt : AlbumOpenEvent) : Void
	{
		notifyChanged(evt);
	}
	
	public function album_close_event(evt : AlbumCloseEvent) : Void
	{
		notifyChanged(evt);
	}
}
