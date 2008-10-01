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
class view.object.PhotoThumb extends Plane
{
	private var id : String;
	private var albumid:String;
	private var open : Boolean = false; 

	public function PhotoThumb(material : MaterialObject3D, width : Number, height : Number)
	{
		super(material, width, height);
	}

	public function activate(aId : String, aAlbumId : String) : Void
	{		
		id = aId;
		albumid = aAlbumId;
		
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
	
	private function onThumbRelease():Void
	{	
//		var target : DisplayObject3D = new DisplayObject3D();
//			target.x = this.x + Stage.width;
//			target.y = this.y;
//		target.z = this.z;
			
//		trace("x: "+target.x+", y: "+target.y+", z: "+target.z);
		
//			target.rotationX = this.rotationX; target.rotationY = this.rotationY; target.rotationZ = this.rotationZ;
//			target.scaleX = this.scaleX; target.scaleY = this.scaleY; target.scaleZ = this.scaleZ;			
		
		EventBroadcaster.getInstance().broadcastEvent(!open ? new PhotoOpenEvent(id, albumid) : new PhotoCloseEvent(id, albumid));
		
		if(open) {
			EventBroadcaster.getInstance().broadcastEvent(new InitializePhotoEvent(id, albumid));
		}
//		EventBroadcaster.getInstance().broadcastEvent(new ChangeCameraExtraEvent(target, this));
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
			z : 200
			});
			
		TweenLite.to(container, 0.5, {_alpha : aActive ? 100 : 50});
	}
	
	public function photo_open_event(evt : PhotoOpenEvent) : Void
	{
		open = true;
		zoomOut(evt.id == id);
	}
	
	public function photo_close_event(evt : PhotoCloseEvent) : Void
	{
		open = false;
		zoomIn();
	}
	
	public function album_close_event(evt : AlbumCloseEvent) : Void
	{	
		if(evt.id == albumid)
		{
			container._visible = false;
		}
	}
	
	public function album_open_event(evt : AlbumOpenEvent) : Void
	{	
		if(evt.id == albumid)
		{
			container._visible = true;
		}
	}
	
//	public function change_thumb_extra_event(evt : ChangeThumbExtraEvent) : Void
//	{	
//		if(open)
//		{
//			var goto : DisplayObject3D = this.extra.goto;
//	
//			this.x -= (this.x - goto.x) / 10;
//			this.y -= (this.y - goto.y) / 10;
//			this.z -= (this.z - goto.z) / 10;
//		}
//	}
}
