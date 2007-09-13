import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
//import com.bourre.events.IEvent;
//import com.bourre.events.BasicEvent;
//import com.bourre.events.EventBroadcaster;
//import com.bourre.data.libs.LibEvent;
//import com.bourre.data.libs.ILibListener;
//import com.bourre.data.collections.Map;
//import com.bourre.transitions.TweenMS;
import com.bourre.utils.Geom;
import com.bourre.log.PixlibStringifier;

import org.papervision3d.cameras.Camera3D;
import org.papervision3d.materials.BitmapAssetMaterial;
import org.papervision3d.materials.ColorMaterial;
import org.papervision3d.scenes.MovieScene3D;
import org.papervision3d.objects.Plane;

//import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.CubeView extends MovieClipHelper
{
	public var holder:MovieClip;
	public var id	: String;

	public var container 	: MovieClip;
	public var scene     	: MovieScene3D;
	public var camera    	: Camera3D;
 
	public function CubeView(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		holder = aContainer;
		id = aID;
		
		super(id, holder);
		initialize();
	}
	private function initialize()
	{
		trace("CubeView initialized!");
		
		init3D();
		holder.onEnterFrame = Delegate.create(this,loop3D);
		
		//var tC = Geom.buildRectangle(holder, 2, 320, 240, 0x9cdfff, 0x9cdfff);
	}
	public function init3D()
	{
		// Create container movieclip and center it
		container = Geom.buildRectangle(holder, 2, 320, 240, 0x9cdfff, 0x9cdfff);
		//container = holder.createEmptyMovieClip( "container", holder.getNextHighestDepth() );
		container._x = 320;
		container._y = 240;

		// Create MovieScene for hotspot mode
		// This scene renders each object in a separate movie clip, so you can add events to them easily.
		// This movie clip is called container.
		scene = new MovieScene3D(container);

		// Create camera
		camera = new Camera3D();
		camera.z = -2000;
		camera.zoom = 1;
		camera.focus = 500;

		// Create material
		//var material :BitmapAssetMaterial = new BitmapAssetMaterial( "Bitmap" );
		var material:ColorMaterial = new ColorMaterial(0xff00ff);
			material.oneSide = false; // Make it double sided

		// Create Planes x50
		var radius:Number = 500;

		for( var i:Number = 0; i < 5; i++ )
		{
			var plane:Plane = new Plane( material, 1.0);
			// Randomize position
			//plane.x = Math.random() * radius - radius/2;
			plane.x = radius - (200 * i);
			plane.y = radius - radius/2;
			plane.z = radius - radius/2;

			// Randomize rotation
			//plane.rotationX = Math.random() * 360;
			plane.rotationX = 360;
			plane.rotationY = 300;
			plane.rotationZ = 360;
			

			// Include in scene
			scene.push( plane );

			var c:MovieClip = plane.container;
				c._alpha = 50;
				c._id = i;
				c.prevRotationY = plane.rotationY;
				
			c.onRollOver = function()
			{
				this._alpha = 100;
				this.displayObject3D.scaleX = this.displayObject3D.scaleY = 1.5;
				this.displayObject3D.rotationY = 0;
			};

			c.onRollOut = c.onReleaseOutside = function()
			{
				this._alpha = 50;
				this.displayObject3D.scaleX = this.displayObject3D.scaleY = 1;
				this.displayObject3D.rotationY = this.prevRotationY;
			};

			c.onPress = function()
			{
				//this.displayObject3D.visible = false;
				this.displayObject3D.x = - radius - (200 * this._id);
			};
			
		}
	}
	public function loop3D()
	{
		// Some easing for the camera
		//camera.x -= (camera.x + 2 * container._xmouse) / 8;
		//camera.y -= (camera.y + 2 * container._ymouse) / 8;

		// Render
		scene.renderCamera( camera );
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}
