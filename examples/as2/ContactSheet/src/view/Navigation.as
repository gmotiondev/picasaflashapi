﻿import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;
import control.photo.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
class view.Navigation extends MovieClipHelper
{
	public function Navigation(aId : String, aC : MovieClip)
	{
		super(aId, aC);
		
		initialize();
	}
	
	private function initialize() : Void
	{
		var l : MovieClip = view.attachMovie("l", "l", 1002);
		var r : MovieClip = view.attachMovie("r", "r", 1003);
		
		l._x = 0; l._y = 0;
		r._x = l._width + 5; r._y = 0;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);
				
		centerize();
	}
		
	private function onPrevPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPrevEvent());
	}
	
	private function onNextPhoto() : Void
	{	
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
	}

	private function centerize() : Void
	{
		move(Math.round((Stage.width - view._width)/2), Stage.height - 60);
	}
	
	private function resize_event(evt : ResizeEvent) : Void
	{
		centerize();
	}
}