/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.commands.Delegate;

import plugins.grid.control.PhotoGetNextEvent;
import plugins.grid.control.PhotoGetPreviousEvent;
import plugins.grid.control.ResizeEvent;

class plugins.grid.view.Navigation extends AbstractMovieClipHelper
{
	public function Navigation(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);
		initialize();
	}
	
	private function initialize():Void
	{
		var l:MovieClip = view.attachMovie("l","l",1002);
		var r:MovieClip = view.attachMovie("r","r",1003);
		
		l._x = 0; l._y = 0;
		r._x = l._width + 5; r._y = 0;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);
		r.onRelease = Delegate.create(this, onNextPhoto);
		
		centerize();
	}
		
	private function onPrevPhoto():Void
	{	
		getOwner().firePrivateEvent(new PhotoGetPreviousEvent(getOwner()));
		//protect();
	}
	
	private function onNextPhoto():Void
	{	
		getOwner().firePrivateEvent(new PhotoGetNextEvent(getOwner()));
		//protect();
	}
	
	private function centerize():Void
	{
		move(Stage.width/2 - view._width/2, Stage.height - 60);
	}
	/*
	private function protect():Void
	{
		container.r.onRelease = container.l.onRelease = null;
		
		var t:TweenMS = null;
			t = new TweenMS(null, '_alpha', 0, 500, 0);
			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, unprotect);
			t.start();
	}
	
	private function unprotect():Void
	{
		container.l.onRelease = Delegate.create(this, onPrevPhoto);
		container.r.onRelease = Delegate.create(this, onNextPhoto);
	}*/
	
	// listen to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
}