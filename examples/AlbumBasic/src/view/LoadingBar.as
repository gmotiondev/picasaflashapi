/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import control.*;

class view.LoadingBar extends MovieClipHelper
{	
	private var __loader:MovieClip;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);

		EventBroadcaster.getInstance().addEventListener(Controller.PROGRESS_SET_EVENT, Delegate.create(this, onProgressSetEvent));

		__loader = Geom.buildRectangle(view, 10005, 320, 2, 0xD40073, 0xD40073);
		show();
	}
	
	// listen to progress event
	public function onProgressSetEvent(e:ProgressSetEvent):Void
	{
		
		var tPercent:Number = ProgressSetEvent(e).percent;
		
		setVisible(tPercent < 100); 
		__loader._xscale = 100 - tPercent;
	}
	
	// listen to model
	public function onResize(event:ScreenResizeEvent):Void
	{
		__loader = Geom.buildRectangle(view, 10005, Stage.width, 2, 0xD40073, 0xD40073);
	}
}
