﻿/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;


//TODO: Pagination
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
	private var _mc : MovieClip;
		
	public function Navigation(aID:String,aMC:MovieClip)
	{
		super(aID,aMC);
		
		container = view.createEmptyMovieClip("nav",2);
		_mc = view.createEmptyMovieClip("world",10);
		// initialize();
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
