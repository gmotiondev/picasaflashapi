/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;

import control.*;
import view.ThumbContainer;
import sk.prasa.visual.layout.GridLayout;

class view.ThumbHolder extends MovieClipHelper implements ILibListener
{	
	private var __grid:GridLayout;
	private var __children:Array = [];
	
	public function ThumbHolder(aId:String, aC:MovieClip)
	{
		super(aId,aC);
		
		show();
		move(350,20);
		__grid = new GridLayout(5, 5);
	}
	
	public function addChild(aID:String):ThumbContainer
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("p_"+aID, view.getNextHighestDepth());
		var tThumb:ThumbContainer = new ThumbContainer(aID, tHolder);
		
		__grid.addChild(tHolder);
		__children.push(tHolder);
		
		return tThumb;
	}
	
	public function removeAllChildren():Void
	{	
		for(var a:Number = 0; a < __children.length; a++)
		{
			__children[a].removeMovieClip();
		}
		
		__grid.reset();
		__children = [];
	}
	
	public function onLoadInit(e:LibEvent):Void
	{	
		__grid.draw();
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SetProgressEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		__grid.draw();
	}
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}	
}