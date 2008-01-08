/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;
import be.netdust.visual.data.DataProvider;

import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;

import control.GetPhotosEvent;

class view.dialog.PageDialog extends Panel
{	
	public function PageDialog(aHolder:MovieClip)
	{
		trace("creating page dialog")
		super("Pages");

		setUI(aHolder.createEmptyMovieClip("page_panel",3));
		setPosition(20, 370);

		addChild(new Label("pages"))
		create();
	}
	
	private function onClick(event:IEvent):Void
	{
		//EventBroadcaster.getInstance().broadcastEvent(new GetPhotosEvent(event.getTarget().currentItem.getValue()));
	}
}