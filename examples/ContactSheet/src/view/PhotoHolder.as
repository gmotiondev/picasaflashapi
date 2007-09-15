import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoHolder extends MovieClipHelper
{	
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		initialize();
	}
	
	private function initialize()
	{
		show();
	}
}