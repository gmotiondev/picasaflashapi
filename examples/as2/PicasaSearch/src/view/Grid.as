import sk.prasa.visual.organization.ui.organizers.ILayoutOrganizer;
import sk.prasa.visual.organization.ui.organizers.GridOrganizer;

import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;

import control.*;
import view.Thumb;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.Grid extends MovieClipHelper implements ILibListener
{	
	private var grid : ILayoutOrganizer;
	private var __children:Array = [];
	
	public function Grid(aId:String, aC:MovieClip)
	{
		super(aId,aC);
		
		show();
		grid = new GridOrganizer(view, 768, 576, 12, 9);
	}
	
	public function addChild(aID:String):Thumb
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("p_"+aID, view.getNextHighestDepth());
		var tThumb:Thumb = new Thumb(aID, tHolder);
		
		grid.addToLayout(tHolder, true, true);
		__children.push(tHolder);
		
		return tThumb;
	}
	
	public function removeAllChildren():Void
	{	
		for(var a:Number = 0; a < __children.length; a++)
		{
			__children[a].removeMovieClip();
		}
		
		grid.removeLinks();
		__children = [];
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SetProgressEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{
	}
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}	
}