import com.bourre.commands.Delegate;
import com.bourre.data.libs.*;
import com.bourre.events.IEvent;
import com.bourre.visual.MovieClipHelper;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoView extends MovieClipHelper implements ILibListener
{
	public function PhotoView(name : String, mc : MovieClip)
	{
		super(name, mc);
		
		initialize();
	}

	private function initialize() : Void
	{	
		view.onRelease = Delegate.create(this, onPhotoRelease);
	}

	private function centerize() : Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
	
	public function onLoadInit(evt : LibEvent) : Void
	{
		//var tMC : MovieClip = evt.getTarget().getContent();
		centerize();
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		//EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{
		// libstack is complete!
	}

	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}

	private function onPhotoRelease() : Void
	{
		if(isVisible()) hide();	
	}
	
	public function notifyChanged(evt : IEvent) : Void
	{
		_oEB.broadcastEvent( evt );
	}
	
	public function photo_open_event(evt : PhotoOpenEvent) : Void
	{
	}
	
	public function photo_close_event(evt : PhotoCloseEvent) : Void
	{
	}
//	
//	public function album_open_event(evt : AlbumOpenEvent) : Void
//	{		
//	}
//	
//	public function album_close_event(evt : AlbumCloseEvent) : Void
//	{
//	}
}
