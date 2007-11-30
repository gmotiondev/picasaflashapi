import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.BasicEvent;

import sandy.core.data.Vector;
import sandy.core.group.*;
import sandy.primitive.*;
import sandy.view.*;
import sandy.core.*;
import sandy.skin.*;
import sandy.util.Ease;
import sandy.core.transform.*;
import sandy.events.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.CubeView extends MovieClipHelper
{
	private var _mc : MovieClip;
 
	public function CubeView(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		_mc = view.createEmptyMovieClip("world", 100);
		
		initialize();
	}
	
	private function initialize ( Void ):Void
	{
		var w:World3D = World3D.getInstance();
			w.setRootGroup( __createScene() );
		__createCams();
		w.render();
	}
	
	private function __createCams ( Void ):Void
	{
		var mc:MovieClip;
			mc = _mc.createEmptyMovieClip("screen", 10);
		
		var screen:ClipScreen;
			screen = new ClipScreen(300, 300, 0xff00ff );
	
		var cam:Camera3D;
			cam = new Camera3D( 700, 500 );
			cam.setPosition( 0, 0, 0 );
		
		World3D.getInstance().addCamera( cam );
	}
	
	private function __createScene ( Void ):Group
	{
		var bg:Group = new Group();
		// -- interpolator
		var myEase:Ease = new Ease();
		var tgRotation:TransformGroup = new TransformGroup();
		var tgTranslation:TransformGroup = new TransformGroup();
		//
		var translation:Transform3D = new Transform3D();
			translation.translate( 0, 0, 500 );
			tgTranslation.setTransform( translation );
		//
		var rotint:RotationInterpolator = new RotationInterpolator( myEase.create(), 500 );
		// -- listener
			rotint.addEventListener( InterpolationEvent.onEndEVENT, this, __yoyo );
			rotint.addEventListener( InterpolationEvent.onProgressEVENT, this, __playMouse );
		// -- earth
		var box:Box = new Box( 100, 80, 50, "tri", 2 );
		var skin:Skin;
			//skin = new TextureSkin( _b );
			skin = new MixedSkin( 0xFF0000, 100, 0x0, 50, 2 );
			
		box.setSkin( skin );
		//
		tgRotation.setTransform( rotint );
		tgRotation.addChild( box );
		tgTranslation.addChild( tgRotation );
		
		bg.addChild( tgTranslation );
		//
		return bg;
	}
	
	private function __yoyo( e:InterpolationEvent ):Void
	{
		e.getTarget().redo();
	}
	
	private function __playMouse( e:InterpolationEvent ):Void
	{
		var difX:Number = 150 - _mc._xmouse;
		var difY:Number = 150 - _mc._ymouse;
		var dist:Number = Math.sqrt( difX*difX  + difY*difY );
		RotationInterpolator(e.getTarget()).setAxisOfRotation( new Vector( -difY, difX, 0 ) );
		RotationInterpolator(e.getTarget()).setDuration( 10000 / dist );
	}
}
