/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import control.Controller;
import control.ProgressSetEvent;

class view.LoadingBar extends MovieClipHelper
{	
	private var __loader:MovieClip;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);

		EventBroadcaster.getInstance().addEventListener(Controller.PROGRESS_SET_EVENT, Delegate.create(this, onProgressSetEvent));

		__loader = Geom.buildRectangle(view, 10005, 319, 4, 0xD40073, 0xD40073);
		show();
	}
	
	// listen to progress event
	public function onProgressSetEvent(e:ProgressSetEvent):Void
	{
		
		var tPercent:Number = ProgressSetEvent(e).percent;
		
		setVisible(tPercent < 100); 
		__loader._xscale = 100 - tPercent;
	}	
}
