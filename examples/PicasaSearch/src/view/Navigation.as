/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;

import control.*;

//TODO: Pagination
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
		
	public function Navigation(aID:String,aMC:MovieClip)
	{
		super(aID,aMC);
		
		container = view.createEmptyMovieClip("nav",2);
		initialize();
	}

	private function initialize():Void
	{
		var l:MovieClip = container.attachMovie("l","l",1002);
		var r:MovieClip = container.attachMovie("r","r",1003);
		
		l.onRelease = Delegate.create(this, onPrevPage);		r.onRelease = Delegate.create(this, onNextPage);
		
		//l.onRollOver = r.onRollOver = Delegate.create(this, onContainerOver);
		//r.onRollOut = r.onRollOut = Delegate.create(this, onContainerOut);
		
		centerize();		
	}
	
	private function onPrevPage():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPageEvent("prev"));
	}
	
	private function onNextPage():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPageEvent("next"));
	}
	
	private function centerize():Void
	{
		container.l._x = 20;
		container.l._y = Stage.height - container.l._height - 20;
		
		container.r._x = Stage.width - container.r._width - 20;
		container.r._y = Stage.height - container.r._height - 20;
	}
	
	public function onResize(event:ScreenResizeEvent):Void
	{
		centerize();
	}
}
