/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;

import control.*;
import view.Thumb;

class view.ThumbHolder extends MovieClipHelper implements ILibListener
{	
	private var __grid:sk.prasa.visual.layout.GridLayout;
	
	public function ThumbHolder(aId:String, aC:MovieClip)
	{
		super(aId,aC);
		
		__grid = new sk.prasa.visual.layout.GridLayout(6, 6);
			
		show();
		centerize();
	}
	
	public function addChild(aId:String, aSummary:String):Thumb
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("p_"+aId, view.getNextHighestDepth());
		var tThumb = new Thumb(aId, tHolder, aSummary);
		
		__grid.addChild(tThumb.view);
		
		return tThumb;
	}
	
	public function setTitle(a:String):Void
	{			
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.blockIndent = 5;
			tTF.color = 0xffffff;
			
		view.createTextField("tf_album_title", 2, 0, -20, 313, 16);
		var tF:TextField = view["tf_album_title"];
			tF.embedFonts = true;
			tF.background = true;
			tF.backgroundColor = 0xd40073;
			tF.html = true;
			tF.htmlText = a;
			tF.setTextFormat(tTF);
	}

	private function centerize():Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
	
	// Listening to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
		
	public function onLoadInit(e:LibEvent):Void
	{	
		centerize();
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		__grid.draw();
		centerize();
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
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
