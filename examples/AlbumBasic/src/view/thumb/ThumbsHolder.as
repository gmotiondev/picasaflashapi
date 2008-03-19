import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;
import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.visual.MovieClipHelper;

import sk.prasa.visual.layout.GridLayout;

import control.*;
import view.thumb.Thumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.ThumbsHolder extends MovieClipHelper implements ILibListener
{
	private var grid:GridLayout;
	
	public function ThumbsHolder(aId : String, aC : MovieClip)
	{
		super(aId,aC);

		move(325, 26);
		
		grid = new GridLayout(4, 6);
		grid.padding = 5;
	}
	
	public function addChild(aID : String, aTitle : String) : Thumb
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("thumb_holder_" + aID, view.getNextHighestDepth());
		var tThumb : Thumb = new Thumb(aID, tHolder, aTitle);
		
		grid.addChild(tHolder);
		addListener(tThumb);
		
		return tThumb;
	}

	public function notifyChanged(evt : IEvent) : Void
	{
		_oEB.broadcastEvent(evt);
	}

	public function onLoadInit(evt : LibEvent):Void
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
		
		notifyChanged(new BasicEvent(new EventType("onInitialize")));
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Thumb loading time out: "+evt.getName());
	}	
}