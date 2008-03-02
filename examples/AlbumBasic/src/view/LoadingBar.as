/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import control.*;

class view.LoadingBar extends MovieClipHelper
{	
	private var l:MovieClip;
	private var c:Number = 0xD40073;
	
	public function LoadingBar(aId:String, aC:MovieClip)
	{
		super(aId,aC);
	}
	
	private function initialize() : Void
	{
		l = Geom.buildRectangle(view, 10005, Stage.width, 2, c, c);
	}
	
	// listen to model
	public function onProgress(evt : ProgressEvent):Void
	{
		setVisible(evt.percent < 100); 
		l._xscale = 100 - evt.percent;
	}
	
	public function onResize(evt : ResizeEvent):Void
	{
		initialize();
	}
}
