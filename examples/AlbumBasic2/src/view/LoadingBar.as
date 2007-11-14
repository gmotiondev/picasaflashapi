/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;
import com.bourre.events.EventBroadcaster;

import control.Controller;
import control.ProgressSetEvent;

class view.LoadingBar extends MovieClipHelper
{	
	private var __loader:MovieClip;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);

		EventBroadcaster.getInstance().addEventListener(Controller.PROGRESS_SET_EVENT, onProgressSetEvent);

		__loader = Geom.buildRectangle(view, 10005, Stage.width, 4, 0xffffff, 0xffffff);
		show();
	}
	
	public function onProgressSetEvent(e:ProgressSetEvent):Void
	{
		var tPercent:Number = ProgressSetEvent(e).percent;
		
		setVisible(tPercent < 100); 
		__loader._xscale = 100 - tPercent;
	}	
}
