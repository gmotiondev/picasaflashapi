import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class view.LoadingBar extends MovieClipHelper
{	
	private var LOADER:MovieClip;
	
	public function LoadingBar(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		initialize();
	}
	
	private function initialize()
	{
		LOADER = Geom.buildRectangle(view, 10005, Stage.width, 4, 0xffffff, 0xffffff);
		show();
	}
	
	public function setProgress(aPercent:Number):Void
	{
		LOADER._xscale = 100 - aPercent;
	}	
}
