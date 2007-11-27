/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.StringEvent;

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

	private function onStartSearch(e:StringEvent):Void
	{
		EventBroadcaster.getInstance().dispatchEvent(new GetPhotosEvent(escape(e.getString())));
	}
	
	private function setSearchResult(aResults:String):Void
	{
		trace("setSearchResult("+aResults+")");
		__dialog.displayResults(aResults);
	}
	
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2), Math.round(Stage.height/2 - view._height/2));
	}
}
