import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.ProgressEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.LoadingBar extends MovieClipHelper
{
	private var l : MovieClip;
	private var c : Number = 0xd40073;
	
	public function LoadingBar(name : String, mc : MovieClip)
	{
		super(name, mc);
	}
	
	public function onProgress(evt : ProgressEvent) : Void
	{	
		if(!l) l = Geom.buildRectangle(view, 10005, Stage.width, 2, c, c);
		
		setVisible(evt.percent < 100); 
		l._xscale = 100 - evt.percent;
	}	
}