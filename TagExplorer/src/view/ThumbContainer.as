/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;

class view.ThumbContainer extends MovieClipHelper
{
	private var title:String;
	private var id:String;
	private var __b:MovieClip;
	
	public function ThumbContainer(aID:String, aContainer:MovieClip, aTitle:String)
	{
		super(aID, aContainer);
		
		id = aID;
		title = aTitle;
	}
	
	private function onRollOver():Void
	{
		// zoom in and show infos
	}
	
	private function onRollOut():Void
	{
		// zoom out and hide infos
	}
	
	private function onRelease():Void
	{
		// open browser window with link on the photo
	}
}
