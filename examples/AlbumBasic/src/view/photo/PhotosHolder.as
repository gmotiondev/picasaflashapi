import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.utils.Geom;

import control.*;
import control.photo.*;
import view.photo.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.PhotosHolder extends MovieClipHelper implements ILibListener
{	
	private var t : TextField;
	private var f : TextFormat;
	private var b : MovieClip; 
	private var c : Number = 0xD40073;
	
	public function PhotosHolder(aId : String, aC : MovieClip)
	{
		super(aId, aC);
		
		b = Geom.buildRectangle(view, 5, Stage.width, 20, c, c);
	}
	
	private function initialize() : Void
	{
		//Geom.buildRectangle(view, view.getNextHighestDepth(), Stage.width, 20, 0xD40073, 0xD40073);
		
		f = new TextFormat("kroeger", 8, 0xffffff);
		view.createTextField("title", view.getNextHighestDepth(), 50, 3, Stage.width, 20);
		t = view["title"]; 
		t.embedFonts = true;
	}

	public function addChild(aId:String, aHide:Boolean) : Photo
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("p_"+aId, view.getNextHighestDepth());
		
		return new Photo(aId, tHolder, aHide);
	}
	
	public function onLoadInit(evt : LibEvent) : Void
	{	
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		initialize();
		
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
	} 
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}
	
	// listen to the model
	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		t.text = evt.title;
		t.setTextFormat(f);
	}
}