/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;

import sandy.core.World3D;
import sandy.core.scenegraph.*;
import sandy.primitive.*;
import sandy.materials.*;

//TODO: Pagination
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
	
	public function Navigation(aID:String,aMC:MovieClip)
	{
		super(aID,aMC);
		
		container = view.createEmptyMovieClip("nav",2);
		// initialize();
		// sandy_init();
	}
	
	private function sandy_init():Void
	{
		var tContainer:MovieClip = view.createEmptyMovieClip("sandyScene", 10)
		World3D.getInstance().container = tContainer;
		
		World3D.getInstance().root = _createScene();
	        // we create the camera. It is very important to pass correct values as viewport dimension. Usually your swf dimension for a simple demo.
		var myCamera:Camera3D = new Camera3D(500, 500);
		World3D.getInstance().camera = myCamera;
		World3D.getInstance().root.addChild(myCamera);		
	        // we need to call ourself now the render method.
	        // Here we use the enterframe event, using a Delegate command.
		tContainer.onEnterFrame = Delegate.create(this, _onRender);
	}
	
	private function _createScene( Void ):Group
	{
		var g:Group = new Group("root");
		// we create the box
		var myBox:Box = new Box( "myBox", 100, 100, 100);
	        // we set its position, lot simpler isn't it? 
		myBox.x = 10;
		myBox.y = -20;
		myBox.z = 300;
		// we apply the bitmap appearance
		myBox.appearance = new Appearance( new ColorMaterial( 0xcecece, 50 ) );
		// link the object to the group to make it displayable.
		g.addChild( myBox );
		return g;
	}

	// we render the world
	private function _onRender( Void ):Void
	{
		World3D.getInstance().render();
	}
	
	private function initialize():Void
	{
		var l:MovieClip = container.attachMovie("l","l",1002);
		var r:MovieClip = container.attachMovie("r","r",1003);
		
		l._x = 0; l._y = 0;
		r._x = l._width + 5; r._y = 0;
		
		//l.onRelease = Delegate.create(this, onPrevPhoto);		//r.onRelease = Delegate.create(this, onNextPhoto);
		
		//l.onRollOver = r.onRollOver = Delegate.create(this, onContainerOver);
		//r.onRollOut = r.onRollOut = Delegate.create(this, onContainerOut);		
	}	
}
