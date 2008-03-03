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
	}
	
	public function addChild(aId : String) : Thumb
	{
		var tH : MovieClip = view.createEmptyMovieClip("t_"+aId, view.getNextHighestDepth());
		var tT = new Thumb(aId, tH);
		
		grid.addChild(tT.view);
		
		return tT;
	}
	
	public function onLoadInit(evt : LibEvent) : Void
	{
		grid.draw();
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		grid.draw();
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
	}
}
