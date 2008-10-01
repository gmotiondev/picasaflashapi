import control.ResizeEvent;

import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.photo.*;
import view.photo.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.PhotosHolder extends MovieClipHelper
{	
	private var t : TextField;
	private var f : TextFormat;
	private var b : MovieClip; 
	private var c : Number = 0xD40073;
	
	public function PhotosHolder(aId : String, aC : MovieClip)
	{
		super(aId, aC);
		
		initialize();
	}
	
	private function initialize() : Void
	{
		Geom.buildRectangle(view, 5, Stage.width, 20, 0xD40073, 0xD40073);
		
		if(!t)
		{
			f = new TextFormat("kroeger", 8, 0xffffff);
			view.createTextField("title", 10, 50, 3, Stage.width, 20);
			t = view["title"]; 
			t.embedFonts = true;
		}
	}

	public function addChild(aId : String, aUrl : String) : Photo
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("photo_holder_"+aId, view.getNextHighestDepth());
			tHolder._y = 21;
			
		return new Photo(aId, tHolder, aUrl);
	}
	
	public function onResize(evt : ResizeEvent) : Void
	{
		initialize();
	}

	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		t.text = evt.title;
		t.setTextFormat(f);
	}
}