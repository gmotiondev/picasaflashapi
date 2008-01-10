/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

import be.netdust.visual.data.DataProvider;
import be.netdust.visual.object.ListItem;
import be.netdust.visual.object.Label;
import be.netdust.visual.containers.TitleBox;

import control.*;
import view.dialog.*;

class view.MainView extends MovieClipHelper
{
	private var __sdialog:SearchDialog;
	private var __pdialog:PageDialog;
	
	public function MainView(aID:String, aContainer:MovieClip)
	{
		super(aID, aContainer);
		
		initialize();
	}
	
	private function initialize():Void
	{
		__sdialog = new SearchDialog(view);
		__sdialog.addEventListener(new EventType("onStartSearch"),this);
	}

	public function setTags(o:Object):Void
	{
		var tDP:DataProvider = new DataProvider();

		for(var a:Number = 0; a < o.length; a++)
		{
			tDP.addItem(new ListItem(o[a].summary+" ("+o[a].gphoto.weight+")",o[a].summary));
		}
		__sdialog.setTagList(tDP);
	}
	
	// listen to the model.
	public function onResize(e:ScreenResizeEvent):Void
	{
	}
	
	public function set_photos_event():Void
	{
		__pdialog = new PageDialog(view, 110, 25);
		trace("got photos list!");
	}
	
	public function get_page_event(event:GetPageEvent):Void
	{
		__sdialog.get_page_event(event);
		//__pdialog.get_page_event(event);
	}
}