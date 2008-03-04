import control.PhotoClickEvent;
import control.ThumbClickEvent;
import control.ProgressEvent;

import com.bourre.events.EventBroadcaster;

import view.Thumb;

import com.bourre.data.libs.*;
import com.bourre.visual.MovieClipHelper;

import sk.prasa.visual.layout.GridLayout;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Thumbs extends MovieClipHelper implements ILibListener
{
	private var grid : GridLayout;

	public function Thumbs(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		grid = new GridLayout(3, 3);
		grid.padding = 2;
	}
	
	public function addChild(aId : String) : Thumb
	{
		var tH : MovieClip = view.createEmptyMovieClip("t_"+aId, view.getNextHighestDepth());
		var tT = new Thumb(aId, tH);
		
		grid.addChild(tT.view);
		addListener(tT);
		
		return tT;
	}
	
	public function onLoadInit(evt : LibEvent) : Void
	{
		grid.draw();
		centerize();
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		grid.draw();
		centerize();
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
	}
	
	private function centerize() : Void
	{
		move(Math.round((Stage.width - view._width) / 2), 15);
	}
	
	public function thumb_click_event(evt : ThumbClickEvent) : Void
	{
		hide();
	}
	
	public function photo_click_event(evt : PhotoClickEvent) : Void
	{
		show();
	}
}
