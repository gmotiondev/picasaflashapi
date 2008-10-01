import org.papervision3d.core.proto.DisplayObject3D;
import org.papervision3d.core.proto.MaterialObject3D;
import org.papervision3d.objects.Plane;

import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;

import gs.TweenLite;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.object.AlbumThumb extends Plane
{
	private var id : String;
	private var open : Boolean = false; 
	
	public function AlbumThumb(material : MaterialObject3D, width : Number, height : Number)
	{
		super(material, width, height);		
	}

	public function activate(aId : String) : Void
	{		
		id = aId;
		container.onRelease = Delegate.create(this, onThumbRelease);
		
		extra = {
			prev: new DisplayObject3D({
				x : x,
				y : y,
				z : z,
				rotationX : rotationX,
				rotationY : rotationY,
				rotationZ : rotationZ,
				scaleX : scaleX,
				scaleY : scaleY,
				scaleZ : scaleZ
				})
		};
	}
	
	private function onThumbRelease() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(!open ? new AlbumOpenEvent(id) : new AlbumCloseEvent(id));
		
		if(open) {
			EventBroadcaster.getInstance().broadcastEvent(new InitializePhotosEvent("thisispinkfu", id));
		}
	}
	
	private function zoomIn() : Void
	{
		TweenLite.to(this, 0.5, {
			x : extra.prev.x,
			y : extra.prev.y,
			z : extra.prev.z,
			rotationX : extra.prev.rotationX,
			rotationY : extra.prev.rotationY,
			rotationZ : extra.prev.rotationZ
			});
			
		TweenLite.to(container, 0.5, {_alpha : 100});
	}
	
	private function zoomOut(aActive : Boolean) : Void
	{
		TweenLite.to(this, 0.5, {
			x : -300, 
			y : -100, 
			z : aActive ? Math.round(Math.random() * 20) : 50,
			rotationZ : aActive ? 0 : Math.round(Math.random() * 180)
			});
			
		TweenLite.to(container, 0.5, {_alpha : aActive ? 100 :  Math.round(Math.random() * 80)});
	}
	
	public function album_open_event(evt : AlbumOpenEvent) : Void
	{
		open = true;
		zoomOut(evt.id == id);
	}
	
	public function album_close_event(evt : AlbumCloseEvent) : Void
	{
		open = false;
		zoomIn();
	}
}
