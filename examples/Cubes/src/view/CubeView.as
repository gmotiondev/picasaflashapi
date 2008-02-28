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

	// _______________________________________________________________________
	//                                                                  vars3D
	var container :MovieClip;
	var scene     :Scene3D;
	var camera    :Camera3D;

	// _______________________________________________________________________
	//                                                                    Main
	public function CubeView(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		init3D();

		view.onEnterFrame = Delegate.create(this,loop3D);

	}
	
	// _______________________________________________________________________
	//                                                                  Init3D
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
		camera.z = -2000;
		camera.zoom = 1;
		camera.focus = 500;

		// Create material
		//var material :BitmapAssetMaterial = new BitmapAssetMaterial("Bitmap");
		var material:ColorMaterial = new ColorMaterial();
		material.oneSide = false; // Make it double sided

		// Create Planes x50
		var radius:Number = 2500;

		for( var i:Number = 0; i < 20; i++ )
		{
			var plane :Plane = new Plane( material, 110, 50, 5, 5);

			// Randomize position
			plane.x = Math.random() * radius - radius/2;
			plane.y = Math.random() * radius - radius/2;
			plane.z = Math.random() * radius - radius/2;

			// Randomize rotation
			plane.rotationX = Math.random() * 360;
			plane.rotationY = Math.random() * 360;
			plane.rotationZ = Math.random() * 360;
			
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
