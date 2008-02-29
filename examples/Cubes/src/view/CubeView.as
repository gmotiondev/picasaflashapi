/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;

import org.papervision3d.cameras.Camera3D;
import org.papervision3d.materials.*;
import org.papervision3d.objects.Plane;
import org.papervision3d.scenes.Scene3D;

class view.CubeView extends MovieClipHelper
{
	var container :MovieClip;
	var scene     :Scene3D;
	var camera    :Camera3D;

	public function CubeView(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		init3D();

		view.onEnterFrame = Delegate.create(this, loop3D);
		trace("CubeView is here");
	}

	function init3D()
	{
		// Create container movieclip and center it
		container = view.createEmptyMovieClip( "container", view.getNextHighestDepth() );
		container._x = 320;
		container._y = 240;
		// Create scene
		scene = new Scene3D( container );

		// Create camera
		camera = new Camera3D();
		camera.z = -1000;
		camera.zoom = 1;
		camera.focus = 500;

		// Create material
		//var material :BitmapAssetMaterial = new BitmapAssetMaterial("Bitmap");
		var material:WireframeMaterial = new WireframeMaterial();
		material.oneSide = false; // Make it double sided

		var radius:Number = 2500;

		for( var i:Number = 0; i < 10; i++ )
		{
			var plane :Plane = new Plane( material, 200, 200);

			// Randomize position
			plane.x = -radius/4;
			plane.y = i/10 * radius - radius/4;
			plane.z = 0.5 * radius - radius/2;

			// Randomize rotation
//			plane.rotationX = Math.random() * 360;
//			plane.rotationY = Math.random() * 360;
//			plane.rotationZ = Math.random() * 360;
			
			// Include in scene
			scene.push( plane );
		}
	}

	// _______________________________________________________________________
	//                                                                    Loop
	function loop3D()
	{
		camera.x = -container._xmouse;
		camera.y = -container._ymouse;

		// Render
		scene.renderCamera( camera );
	}
}
