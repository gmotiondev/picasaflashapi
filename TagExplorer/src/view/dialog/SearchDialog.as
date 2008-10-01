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
import control.GetPageEvent;

class view.dialog.SearchDialog extends Panel
{	
	private var __lb:ListBox;
	
	
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
		__lb = new ListBox();
		__lb.rows = 15;

		//__lb.dataprovider = aDP; // cause duplicate on ListItems!
		for(var a:Number = 0; a < aDP.length; a++)
		{
			__lb.addChild(ListItem(aDP.getItemAt(a)));
		}
		
		__lb.addEventListener(new EventType("onClick", this));
			
		return __lb;
	}
	
	public function getCurrentItem():ListItem
	{
		return __lb.currentItem;
	}
	
	private function dispatchGetPhotosEvent(aHasChanged:Boolean):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new GetPhotosEvent(getCurrentItem().getValue(), aHasChanged));
	}

	private function onClick(event:IEvent):Void
	{
		dispatchGetPhotosEvent(true);
	}
	
	public function get_page_event(event:GetPageEvent):Void
	{
		dispatchGetPhotosEvent(false);
	}
}