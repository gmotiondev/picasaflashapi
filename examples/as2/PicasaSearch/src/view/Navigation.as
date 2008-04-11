import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;

import control.*;
import control.page.GetNextPageEvent;
import control.page.GetPrevPageEvent;
import control.thumb.LoadThumbsEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.Navigation extends MovieClipHelper
{
	public function Navigation(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		initialize();
	}

	private function initialize() : Void
	{
		Key.addListener(this);
		
		var l : MovieClip = view.attachMovie("l", "l", 1002);
		var r : MovieClip = view.attachMovie("r", "r", 1003);
		
		l.onRelease = Delegate.create(this, onPrevPage);		r.onRelease = Delegate.create(this, onNextPage);
		
		l._visible = false;
		r._visible = false;
		
		centerize();	
	}

	private function onPrevPage() : Void
	{
		if(view.l._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetPrevPageEvent());
		}
	}

	private function onNextPage() : Void
	{
		if(view.r._visible)
		{
			EventBroadcaster.getInstance().broadcastEvent(new GetNextPageEvent());
		}
	}

	private function centerize() : Void
	{
		var tL : MovieClip = view.l;
		var tR : MovieClip = view.r;
		
		tL._x = 20;
		tL._y = Stage.height - tL._height - 20;
		
		tR._x = Stage.width - tR._width - 20;
		tR._y = Stage.height - tR._height - 20;
	}

	public function load_thumbs_event(evt : LoadThumbsEvent) : Void
	{
		view.l._visible = evt.startIndex > evt.itemsPerPage;
		view.r._visible = evt.startIndex + evt.itemsPerPage < evt.totalResults;
	}

	public function onKeyDown() : Void
	{
		switch(Key.getCode())
		{
			case Key.RIGHT: 
				onNextPage(); 
				break;
			case Key.LEFT: 
				onPrevPage(); 
				break;
			default: 
				break;
		}
	}

	public function onResize(evt : ResizeEvent) : Void
	{
		centerize();
	}
}