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

class view.dialog.SearchDialog extends Panel
{	
	public function SearchDialog(aHolder:MovieClip)
	{
		super("Tag list");

		setUI(aHolder.createEmptyMovieClip("tags_panel",2));
		setPosition(20, 20);

		addChild(new Label("Loading tags ..."))
		create();
	}
	
	public function setTagList(aDP:DataProvider):Void
	{
		removeChilds();
		addChild(getTagList(aDP));

		paint();
	}
	
	private function getTagList(aDP:DataProvider):ListBox
	{
		var tListBox:ListBox = new ListBox();
			tListBox.rows = 15;
			tListBox.dataprovider = aDP;
			tListBox.addEventListener(new EventType("onClick", this));
			
		return tListBox;
	}
	
	private function onClick(event:IEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPhotosEvent(event.getTarget().currentItem.getLabel()));
	}
}