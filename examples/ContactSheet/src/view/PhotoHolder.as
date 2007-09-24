import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoHolder extends MovieClipHelper
{	
	/**
	 * Constructor	 */
	public function PhotoHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		initialize();
	}
	
	/**
	 * initialize point	 */
	private function initialize()
	{
		show();
	}
}