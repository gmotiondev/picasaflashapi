/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.utils.Geom;

import control.*;

class view.PhotoHolder extends MovieClipHelper implements ILibListener
{	
	private var __title:TextField;
	private var __titleTextFormat:TextFormat;
	
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);

		show();
	}
	
	private function insertTitle():Void
	{
		var tBG = Geom.buildRectangle(view,view.getNextHighestDepth(), 319, 20, 0xD40073, 0xD40073);
			tBG._y = 240;
		
		__titleTextFormat = new TextFormat();
		__titleTextFormat.font = "london";
		__titleTextFormat.size = 14;
		__titleTextFormat.leading = -16;
		__titleTextFormat.blockIndent = 10;
		__titleTextFormat.color = 0xffffff;
			
		tBG.createTextField("title", 5, 0, 3, 320, 20);
		
		__title = tBG.title;
		__title.embedFonts = true;
		__title.multiline = false;
		__title.html = true;
		__title.htmlText = "___";
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
		EventBroadcaster.getInstance().broadcastEvent(new SlideShowStartEvent());
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	// listen to the model
	public function photo_set_title_event(e:PhotoSetTitleEvent):Void
	{
		__title.htmlText = PhotoSetTitleEvent(e).title;
		__title.setTextFormat(__titleTextFormat);
	}
}