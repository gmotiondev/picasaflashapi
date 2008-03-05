import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.ProgressEvent;
import control.ResizeEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.LoadingBar extends MovieClipHelper
{	
	private var l : MovieClip;
	private var c : Number = 0xD40073;
	
	public function LoadingBar(name : String, mc : MovieClip)
	{
		super(name, mc);
	}
	
	private function initialize() : Void
	{
		l = Geom.buildRectangle(view, 10005, Stage.width, 2, c, c);
	}
	
	public function onProgress(evt : ProgressEvent) : Void
	{
		setVisible(evt.percent < 100); 
		l._xscale = 100 - evt.percent;
	}
	
	public function onResize(evt : ResizeEvent) : Void
	{
		initialize();
	}
}