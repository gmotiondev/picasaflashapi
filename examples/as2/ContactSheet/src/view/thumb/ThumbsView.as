import sk.prasa.visual.organization.ui.organizers.GridOrganizer;
import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;

import gs.TweenLite;

import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.*;

import control.*;
import view.thumb.Thumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.ThumbsView extends MovieClipHelper implements ILibListener
{	
	private var grid : ILayoutOrganizer;

	public function ThumbsView(aId : String, aC : MovieClip)
	{
		super(aId,aC);
		
		grid = new GridOrganizer(view, 318, 318, 6, 6);
		grid.setAutoAdjustLayout(true);
		
		show();
		centerize();
	}
	
	public function addChild(aId : String) : Thumb
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("thumb_holder_" + aId, view.getNextHighestDepth());
		var tThumb : Thumb = new Thumb(aId, tHolder);
		grid.addToLayout(tHolder, true, true);
		
		return tThumb;
	}
	
	public function setTitle(s : String) : Void
	{			
		view.createTextField("tf_album_title", view.getNextHighestDepth(), 0, -20, 313, 16);
		
		var f : TextFormat = new TextFormat("kroeger", 8, 0xffffff);
			f.indent = 5;
			
		var t : TextField = view["tf_album_title"];
			t.embedFonts = true;
			t.background = true;
			t.backgroundColor = 0xd40073;
			t.text = s;
			t.setTextFormat(f);
	}

	private function centerize() : Void
	{
		TweenLite.to(view, 0.5, {_x : Math.round((Stage.width - view._width)/2), _y : Math.round((Stage.height - view._height)/2)});
	}

	public function resize_event(evt : ResizeEvent) : Void
	{
		centerize();
	}
		
	public function onLoadInit(evt : LibEvent) : Void
	{	
		centerize();
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: " + evt.getName());
	}	
}
