/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.utils.Geom;

import control.*;
import view.Photo;

class view.PhotoHolder extends MovieClipHelper implements ILibListener
{	
	private var __title:TextField;
	private var __titleTextFormat:TextFormat;
	
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);

		show();
	}
	
	public function addChild(aId:String, aHide:Boolean):Photo
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("p_"+aId, view.getNextHighestDepth());
		
		return new Photo(aId, tHolder, aHide);
	}
	
	private function insertTitle():Void
	{
		var tBG = Geom.buildRectangle(view,view.getNextHighestDepth(), Stage.width, 20, 0xD40073, 0xD40073);
		
		__titleTextFormat = new TextFormat();
		__titleTextFormat.font = "Tahoma";
		__titleTextFormat.size = 13;

		__titleTextFormat.blockIndent = 10;
		__titleTextFormat.color = 0xffffff;
			
		tBG.createTextField("title", 5, 30, 0, Stage.width, 20);
		
		__title = tBG.title;
		__title.multiline = false;
		__title.html = true;
		__title.htmlText = "";
		__title.setTextFormat(__titleTextFormat);
	}
	
	public function onLoadInit(e:LibEvent):Void
	{	
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		insertTitle();
		
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	// listen to the model
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		__title.htmlText = evt.title;
		__title.setTextFormat(__titleTextFormat);
	}
}