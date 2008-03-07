import com.bourre.data.libs.GraphicLib;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.transitions.TweenMS;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;

import control.photo.PhotoChangedEvent;
import control.ProgressEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.Photo extends MovieClipHelper implements ILibListener
{
	private var id : String;
	private var url : String;
	private var loaded : Boolean = false;

	public function Photo(aId : String, aC : MovieClip, aUrl : String)
	{
		super(aId, aC);
		
		id = aId;
		url = aUrl;
	}
	
	private function load() : Void
	{
		var tGL : GraphicLib = new GraphicLib(view, 5);
			tGL.addListener(this);
			tGL.load(url);
	}

	public function onLoadInit(evt : LibEvent) : Void
	{	
		loaded = true;
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{		
	} 
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}
	
	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		var t : TweenMS = null;
		
		if(evt.id == id)
		{	
			if(!loaded) load();
			
			t = new TweenMS(view, "_alpha", 100, 250, 0);	
			show();
		} else
		{
			if(isVisible())
			{
				t = new TweenMS(view, "_alpha", 0, 250, 100);
				t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
			}
		}
		
		t.start();
	}
}