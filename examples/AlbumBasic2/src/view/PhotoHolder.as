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
	
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		
		EventBroadcaster.getInstance().addEventListener(Controller.PHOTO_GET_NEXT_EVENT, onPhotoNext);
		EventBroadcaster.getInstance().addEventListener(Controller.PHOTO_GET_PREVIOUS_EVENT, onPhotoPrevious);
		
		show();
	}
	
	public function setTitle(aString:String):Void
	{
		
	}
	
	private function insertTitle(value:String):Void
	{
		var tBG = Geom.buildRectangle(view,view.getNextHighestDepth(),320,20, 0x9cdfff, 0x9cdfff);
			tBG._y = 197;
		
		var tTF:TextFormat = new TextFormat();
			tTF.font = "london";
			tTF.size = 14;
			tTF.leading = -16;
			tTF.blockIndent = 10;
			tTF.color = 0x003C63;
			
		tBG.createTextField("title", 5, 0, 3, 320, 20);
		
		__title = tBG.title;
		__title.embedFonts = true;
		__title.multiline = true;
		__title.html = true;
		__title.htmlText = ""+value;
		__title.setTextFormat(tTF);
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
		insertTitle("default");
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	private function onPhotoNext(e:PhotoGetNextEvent):Void
	{
		trace("onPhotoNext");
	}
	
	private function onPhotoPrevious(e:PhotoGetPreviousEvent):Void
	{
		trace("onPhotoPrevious");
	}
	
}