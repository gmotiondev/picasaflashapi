/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;

class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
		
	public function Navigation(aID:String,aMC:MovieClip)
	{
		super(aID,aMC);
		
		initialize();
	}

	private function initialize():Void
	{
		Key.addListener(this);
		
		var l:MovieClip = view.attachMovie("l","l",1002);
		var r:MovieClip = view.attachMovie("r","r",1003);
		
		l.onRelease = Delegate.create(this, onPrevPhoto);
		r.onRelease = Delegate.create(this, onNextPhoto);
		
		l._visible = false;
		r._visible = false;
		
		centerize();	
	}
	
	private function onPrevPhoto():Void
	{
		if(container.l._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetPrevPhotoEvent());
		}
	}
	
	private function onNextPhoto():Void
	{
		if(container.r._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetNextPhotoEvent());
		}
	}
	
	private function centerize():Void
	{
		container.l._x = 20;
		container.l._y = Stage.height - container.l._height - 20;
		
		container.r._x = Stage.width - container.r._width - 20;
		container.r._y = Stage.height - container.r._height - 20;
	}
	
	//public function initialize_event(evt:InitializeEvent):Void
	//{
	//	container.l._visible = evt.startIndex > evt.itemsPerPage;
	//	container.r._visible = evt.startIndex + evt.itemsPerPage < evt.totalResults;
	//}
	
	public function onKeyDown():Void
	{
		switch(Key.getCode())
		{
			case Key.RIGHT: onNextPhoto(); break;
			case Key.LEFT: onPrevPhoto(); break;
			default: break;
		}
	}
	
	public function resize_event(evt:ResizeEvent):Void
	{
		centerize();
	}
}