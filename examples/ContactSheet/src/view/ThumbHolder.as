import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.ThumbHolder extends MovieClipHelper
{	
	/**
	 * Constructor 
	 */
	public function ThumbHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);	
		initialize();
	}
	
	/**
	 * initialize point	 */
	private function initialize()
	{
		show();
		centerize();
	}
	
	/**
	 * centerize holder	 */
	private function centerize():Void
	{
		move((Stage.width/2 - view._width/2), (Stage.height/2 - view._height/2));
	}
	
	/**
	 * Listening to model	 */
	public function onResize(e:IEvent):Void
	{
		centerize();
	}
	
	/**
	 * Listening to Layout Manager	 */
	public function complete(e:IEvent):Void
	{
		centerize();
	}
	
	/**
	 *	pixlib 
	 */	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}
