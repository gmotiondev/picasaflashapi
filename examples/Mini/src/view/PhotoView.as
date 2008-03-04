import control.PhotoClickEvent;

import com.bourre.commands.Delegate;

import control.LoadPhotoEvent;
import control.ProgressEvent;

import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.*;
import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoView extends MovieClipHelper implements ILibListener
{
	private var id : String;
	private var holder : MovieClip;

	public function PhotoView(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		holder = view.createEmptyMovieClip("photo_holder", 10);
		holder.onRelease = Delegate.create(this, onPhotoRelease);
	}

	public function load(aId : String, aUrl : String) : Void
	{	
		id = aId;
		
		var tGL : GraphicLib = new GraphicLib(holder, 2);
			tGL.addListener(this);
			tGL.setName(aId);
			tGL.load(aUrl);
	}

	private function onPhotoRelease() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new PhotoClickEvent(id));
	}

	public function onLoadInit(evt : LibEvent) : Void
	{
		centerize();
		show();
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		centerize();
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
	}
	
	private function centerize() : Void
	{
		move(Math.round((Stage.width - view._width) / 2), 15);
	}
	
	public function load_photo_event(evt : LoadPhotoEvent) : Void
	{
		load(evt.id, evt.url);
	}
	
	public function thumb_click_event(evt : PhotoClickEvent) : Void
	{
		if(evt.id == id) show();
	}
	
	public function photo_click_event(evt : PhotoClickEvent) : Void
	{
		hide();
	}
}