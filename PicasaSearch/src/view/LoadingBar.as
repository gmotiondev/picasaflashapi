import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.ResizeEvent;
import control.ProgressEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.LoadingBar extends MovieClipHelper
{	
	private var l : MovieClip;
	
	public function LoadingBar(name : String, mc : MovieClip)
	{
		super(name, mc);

		initialize();
	}
	
	private function initialize() : Void
	{
		l = Geom.buildRectangle(view, 10005, Stage.width, 2, 0xD40073, 0xD40073);
	}
	
	public function onResize(evt : ResizeEvent) : Void
	{
		initialize();
	}

	public function onProgress(evt : ProgressEvent) : Void
	{	
		l._visible = (evt.percent < 100); 
		l._xscale = 100 - evt.percent;
	}	
}
