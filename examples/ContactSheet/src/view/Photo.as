/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.events.EventBroadcaster; 
import com.bourre.data.libs.LibEvent;
import com.bourre.commands.Delegate;

import sk.prasa.visual.object.AbstractPhoto;

import control.*;

class view.Photo extends AbstractPhoto
{
	public function Photo(aId:String, aContainer:MovieClip, aHide:Boolean, aUrl:String, aTitle:String)
	{
		super(aId, aContainer, aHide, aUrl, aTitle);
	}
	
	private function close():Void
	{
		hide();
		unprotect();
	}
	
	private function centerize():Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
		
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		setBackground(0xffffff, 0xffffff, 10);
		setTitle();
		
		var tClose = view.attachMovie("c","c",210);
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);
			
		centerize();
	}
	
	// listen to the model
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		if(PhotoChangedEvent(evt).id == id)
		{
			if(!loaded)
			{
				title = evt.title;
				load();
			}
			
			show();
			centerize();
			protect();
		} else
		{
			if(isVisible()) hide();
		}
	}
	
	// Listening to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
}
