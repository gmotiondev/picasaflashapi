import sk.prasa.visual.organization.ui.organizers.GridOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;

import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;
import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.visual.MovieClipHelper;

import control.*;
import view.thumb.Thumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.ThumbsHolder extends MovieClipHelper implements ILibListener
{
	private var __organizer : ILayoutOrganizer;

	public function ThumbsHolder(aId : String, aC : MovieClip)
	{
		super(aId,aC);

		move(325, 26);
		
		__organizer = new GridOrganizer(view, 408, 408, 6, 6);	}
	
	public function addChild(aID : String, aTitle : String) : Thumb
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("thumb_holder_" + aID, view.getNextHighestDepth());
		var tThumb : Thumb = new Thumb(aID, tHolder, aTitle);
		
		__organizer.addToLayout(tHolder, true, true);
		
		addListener(tThumb);
		
		return tThumb;
	}

	public function notifyChanged(evt : IEvent) : Void
	{
		_oEB.broadcastEvent(evt);
	}

	public function onLoadInit(evt : LibEvent):Void
	{
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{		
		notifyChanged(new BasicEvent(new EventType("onInitialize")));
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Thumb loading time out: "+evt.getName());
	}	
}