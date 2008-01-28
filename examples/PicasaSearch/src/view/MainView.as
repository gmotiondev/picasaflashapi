/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

import control.*;
import view.dialog.*;

class view.MainView extends MovieClipHelper
{
	private var __dialog:SearchDialog;
	
	public function MainView(aID:String, aContainer:MovieClip)
	{
		super(aID, aContainer);
		
		initialize();
		centerize();
	}
	
	private function initialize():Void
	{
		__dialog = new SearchDialog(view);
		__dialog.addEventListener(new EventType("onStartSearch"),this);
	}

	private function onStartSearch(e:BasicEvent):Void
	{
		EventBroadcaster.getInstance().dispatchEvent(new GetPhotosEvent(escape(__dialog.getQuery())));
	}
	
	private function setSearchResult(event:InitializeEvent):Void
	{
		var tFrom:Number = event.startIndex;
		var tTo:Number = ((event.startIndex + event.itemsPerPage) > event.totalResults ? event.totalResults : (event.itemsPerPage + event.startIndex));		
		var tRes:String = (event.totalResults == 0) ? "None found" : "Found "+event.totalResults+" photos ("+tFrom+" - "+tTo+").";
		
		__dialog.displayResults(tRes);
	}
	
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2), Math.round(Stage.height/2 - view._height/2));
	}
	
	public function get_next_page_event(e:GetNextPageEvent):Void
	{
		onStartSearch();
	}
	
	public function get_prev_page_event(event:GetPrevPageEvent):Void
	{
		onStartSearch();
	}
	
	// listen to the model.
	public function onResize(e:ScreenResizeEvent):Void
	{
		centerize();
	}
}