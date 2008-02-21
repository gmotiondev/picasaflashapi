/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.commands.Delegate;

import plugins.grid.control.*;

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
		hide();
	}
		
	private function onPrevPhoto():Void
	{	
		getOwner().firePrivateEvent(new PhotoGetPreviousEvent(getOwner()));
	}
	
	private function onNextPhoto():Void
	{	
		getOwner().firePrivateEvent(new PhotoGetNextEvent(getOwner()));
	}
	
	private function centerize():Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round(Stage.height - 60));
	}

	private function protect():Void
	{
		show();
	}
	
	private function unprotect():Void
	{
		hide();
	}
	
	// listen to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
	
	public function protection_event(evt:ProtectionEvent):Void
	{
		if(!evt.protect)
		{
			unprotect();
		} else
		{
			protect();
		}
	}
}