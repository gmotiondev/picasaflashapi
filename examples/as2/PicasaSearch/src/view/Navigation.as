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
		
		Key.addListener(this);
		
		container = view.createEmptyMovieClip("nav",2);
		initialize();
	}

	private function initialize():Void
	{
		var l:MovieClip = container.attachMovie("l","l",1002);
		var r:MovieClip = container.attachMovie("r","r",1003);
		
		l.onRelease = Delegate.create(this, onPrevPage);		r.onRelease = Delegate.create(this, onNextPage);
		
		l._visible = false;
		r._visible = false;
		
		centerize();	
	}
	
	private function onPrevPage():Void
	{
		if(container.l._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetPrevPageEvent());
		}
	}
	
	private function onNextPage():Void
	{
		if(container.r._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetNextPageEvent());
		}
	}
	
	private function centerize():Void
	{
		container.l._x = 20;
		container.l._y = Stage.height - container.l._height - 20;
		
		container.r._x = Stage.width - container.r._width - 20;
		container.r._y = Stage.height - container.r._height - 20;
	}
	
	public function initialize_event(evt:InitializeEvent):Void
	{
		container.l._visible = evt.startIndex > evt.itemsPerPage;
		container.r._visible = evt.startIndex + evt.itemsPerPage < evt.totalResults;
	}
	
	public function onKeyDown():Void
	{
		switch(Key.getCode())
		{
			case Key.RIGHT: onNextPage(); break;
			case Key.LEFT: onPrevPage(); break;
			default: break;
		}
	}
	
	public function onResize(event:ScreenResizeEvent):Void
	{
		centerize();
	}
}