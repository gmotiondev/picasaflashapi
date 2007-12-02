/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.events.*; 
import be.netdust.visual.data.DataProvider;

import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

import control.GetPhotosEvent;

class view.dialog.SearchDialog extends Panel
{	
	public function SearchDialog(aHolder:MovieClip)
	{
		super("Tag list");
		
		setUI(aHolder.createEmptyMovieClip("tags_panel",2));
		setPosition(20, 20);
		
		this.addChild(new Label("Loading tags ..."))
		this.create();
	}
	
	public function setTagList(aDP:DataProvider):Void
	{
		this.removeChilds();
		this.addChild(getTagList(aDP));
		this.paint();
	}
	
	private function getTagList(aDP:DataProvider):ListBox
	{
		var tListBox:ListBox = new ListBox();
			tListBox.dataprovider = aDP;
			tListBox.addEventListener(new EventType("onClick", this));
		
		return tListBox;
	}
	
	private function onClick(event:IEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPhotosEvent(event.getTarget().currentItem.getLabel()));
	}
}