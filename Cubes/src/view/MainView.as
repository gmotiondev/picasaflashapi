import org.papervision3d.cameras.Camera3D;
import org.papervision3d.core.proto.DisplayObject3D;
import org.papervision3d.scenes.MovieScene3D;

import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.visual.MovieClipHelper;

import control.ChangeCameraExtraEvent;
import control.ChangeThumbExtraEvent;

import gs.TweenLite;

import view.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.MainView extends MovieClipHelper
{
	private var __container :MovieClip;
	private var __scene     :MovieScene3D;
	private var __camera    :Camera3D;
	
	public function MainView(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		initialize();
	}
	
	private function initialize():Void
	{
		__container = view.createEmptyMovieClip("container", 5);
		__container._x = 320;
		__container._y = 240;
		
		__scene = new MovieScene3D(__container);
		
		__camera = new Camera3D();
		__camera.z = -1500;
		__camera.zoom = 1;
		__camera.focus = 1500;

		// Store camera properties
		__camera.extra =
		{
			goPosition: new DisplayObject3D(),
			goTarget:   new DisplayObject3D()
		};

		__camera.extra.goPosition.copyPosition( __camera );
		

		view.onEnterFrame = Delegate.create(this, loop);
	}

	private function loop():Void 
	{
		var target     :DisplayObject3D = __camera.target;
		var goPosition :DisplayObject3D = __camera.extra.goPosition;
		var goTarget   :DisplayObject3D = __camera.extra.goTarget;
		
//		__camera.x -= (__camera.x - goPosition.x)/10;
//		__camera.y -= (__camera.y - goPosition.y)/10;
//		__camera.z -= (__camera.z - goPosition.z) /10;
		
		target.x -= (target.x - goTarget.x) /10;
		target.y -= (target.y - goTarget.y) /10;
		target.z -= (target.z - goTarget.z) /10;

		EventBroadcaster.getInstance().broadcastEvent(new ChangeThumbExtraEvent());
		
		TweenLite.to(__camera, 0.5, {
			x : __container._xmouse * 1.5,
			y : __container._ymouse * 1.5
			});
		
		__scene.renderCamera( __camera );
	}
	
	private function centerize() : Void
	{
//		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
	
	public function notifyChanged(evt : IEvent) : Void
	{
		_oEB.broadcastEvent( evt );
	}
	
	public function handleEvent(evt : IEvent) : Void
	{
		if(evt.getType() == "onResize" || evt.getType() == "set_album_thumb_event") centerize();
		if(evt.getType() == "change_camera_extra_event") change_camera_extra_event(ChangeCameraExtraEvent(evt));
		
		notifyChanged(evt);
	}
	
	private function change_camera_extra_event(evt : ChangeCameraExtraEvent) : Void
	{
		__camera.extra.goPosition.x = evt.target.x;
		__camera.extra.goPosition.y = evt.target.y;
		__camera.extra.goPosition.z = evt.target.z;
		
		__camera.extra.goTarget.x = evt.plane.x;
		__camera.extra.goTarget.y = evt.plane.y;
		__camera.extra.goTarget.z = evt.plane.z;
	}
}