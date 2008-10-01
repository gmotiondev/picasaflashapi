import gs.TweenLite;

import sk.prasa.visual.organization.ui.elements.Cell;
import sk.prasa.visual.organization.ui.organizers.TileOrganizer;

import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;

import control.*;
import control.thumb.LoadThumbsEvent;
import view.thumb.Thumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.ThumbsHolder extends MovieClipHelper implements ILibListener
{	
	private var grid : TileOrganizer;
	private var thumbs : Array;
	
	public function ThumbsHolder(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		initialize();
	}
	
	private function initialize() : Void
	{
		for(var a : Number = 0; a < thumbs.length; a++) { Thumb(thumbs[a]).release(); delete thumbs[a]; }
		for(var b : Number = 0; b < grid.getTotalCells(); b++) { grid.getCellAt(b).link.removeMovieClip(); }
		
		thumbs = new Array();
		
		grid.removeLinks();
		grid = new TileOrganizer(view, Stage.width, Stage.height);
		grid.setAutoAdjustLayout(true);
		grid.setTweenFunction(function(cell : Cell) {
			TweenLite.to(cell.link, 0.5, {_x : cell.x, _y : cell.y});
		});
	}
	
	public function addChild(aId : String, aAuthor : String, aTitle : String, aUrl : String) : Thumb
	{
		var tThumb : Thumb = new Thumb(aId, view.createEmptyMovieClip("thumb_holder_" + aId, view.getNextHighestDepth()), aAuthor, aTitle, aUrl);
			thumbs.push(tThumb);

		return tThumb;
	}

	public function onLoadInit(evt : LibEvent) : Void
	{
		var tMC : MovieClip = evt.getTarget().getContent();
		grid.addToLayout(tMC._parent._parent, true);
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
	
	public function onResize(evt : ResizeEvent) : Void
	{
		grid.setWidth(Stage.width);
		grid.setHeight(Stage.height);
	}

	public function load_thumbs_event(evt : LoadThumbsEvent) : Void
	{
		initialize();
	}	
}