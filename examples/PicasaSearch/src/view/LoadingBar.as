/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import control.Controller;
import control.SetProgressEvent;

class view.LoadingBar extends MovieClipHelper
{	
	private var __loader:MovieClip;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);

		EventBroadcaster.getInstance().addEventListener(Controller.SET_PROGRESS_EVENT, Delegate.create(this, onSetProgressEvent));

		__loader = Geom.buildRectangle(view, 10005, Stage.width, 4, 0xffffff, 0xffffff);
		show();
	}
	
	// listen to progress event
	public function onSetProgressEvent(e:SetProgressEvent):Void
	{
		
		var tPercent:Number = SetProgressEvent(e).percent;
		
		setVisible(tPercent < 100); 
		__loader._xscale = 100 - tPercent;
	}	
}
