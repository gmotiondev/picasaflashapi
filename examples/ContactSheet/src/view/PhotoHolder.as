/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.*;
import view.Photo;

class view.PhotoHolder extends MovieClipHelper
{	
	private var __title:TextField;
	private var __titleTextFormat:TextFormat;
	
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);

		show();
	}
	
	public function addChild(aId:String, aUrl:String):Photo
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("p_"+aId, view.getNextHighestDepth());
		return new Photo(aId, tHolder, true, aUrl);
	}
	
	private function insertTitle():Void
	{
		var tBG = Geom.buildRectangle(view,view.getNextHighestDepth(),320,20, 0x9cdfff, 0x9cdfff);
			tBG._y = 197;
		
		__titleTextFormat = new TextFormat();
		__titleTextFormat.font = "london";
		__titleTextFormat.size = 14;
		__titleTextFormat.leading = -16;
		__titleTextFormat.blockIndent = 10;
		__titleTextFormat.color = 0x003C63;
			
		tBG.createTextField("title", 5, 0, 3, 320, 20);
		
		__title = tBG.title;
		__title.embedFonts = true;
		__title.multiline = false;
		__title.html = true;
		__title.htmlText = "";
		__title.setTextFormat(__titleTextFormat);
	}
	
	// listen to the model
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		__title.htmlText = evt.title;
		__title.setTextFormat(__titleTextFormat);
	}
}