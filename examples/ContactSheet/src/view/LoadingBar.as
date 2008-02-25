/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.ProgressSetEvent;

class view.LoadingBar extends MovieClipHelper
{	
	private var __loader:MovieClip;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);

		__loader = Geom.buildRectangle(view, 10005, Stage.width, 4, 0xd40073, 0xd40073);
		show();
	}
	
	// listen to progress event
	public function progress_set_event(evt:ProgressSetEvent):Void
	{	
		setVisible(evt.percent < 100); 
		__loader._xscale = 100 - evt.percent;
	}	
}
