import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.transitions.TweenMS;
import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoContainer extends MovieClipHelper
{
	public var container:MovieClip;
	public var id:String;
	public var title:String;
	
	public function PhotoContainer(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		
		EventBroadcaster.getInstance().addEventListener(Controller.PHOTO_CHANGED_EVENT, Delegate.create(this, onPhotoChanged));
		
		id = aID;
		container = aContainer;
	
		setVisible(!aHide);
	}
	/*
	public function PhotoChanged(e:IEvent)
	{
		var tId = e.getTarget().getIdString();
		var t:TweenMS = null;
		
		if(tId == id)
		{
			t = new TweenMS(view, '_alpha', 100, 500, 0);
			show();
		} else
		{
			t = new TweenMS(view, '_alpha', 0, 500, 100);
			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
		}
		t.start();
	}
	*/
	private function onPhotoChanged(e:PhotoChangedEvent):Void
	{
		trace("PhotoChangedEvent: "+e.id+"/"+id);
		setVisible(PhotoChangedEvent(e).id == id);
	}
}
