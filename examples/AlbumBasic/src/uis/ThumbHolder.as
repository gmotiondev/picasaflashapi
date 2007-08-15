import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class uis.ThumbHolder extends MovieClipHelper
{	
	public function ThumbHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);	
		initialize();
	}
	
	private function initialize()
	{
		move(700,30);
		show();
	}
}
