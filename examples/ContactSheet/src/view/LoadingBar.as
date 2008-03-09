import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.ResizeEvent;
import control.ProgressEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.LoadingBar extends MovieClipHelper
{
	private var COLOR : Number = 0xd40073;
	private var HEIGHT : Number = 2;
	
	public function LoadingBar(aId : String, aC : MovieClip)
	{
		super(aId, aC);
		
		initialize();
	}
		
	private function initialize() : Void
	{
		view.l = Geom.buildRectangle(view, 2, Stage.width, HEIGHT, COLOR, COLOR);
	}
	
	private function setProgress(p : Number) : Void
	{
		view.l._visible = (p < 100);
		view.l._xscale = 100 - p;
	}
	
	private function resize_event(evt : ResizeEvent) : Void
	{
		initialize();
	}
	
	private function progress_event(evt : ProgressEvent) : Void
	{	
		setProgress(evt.percent);
	}
}