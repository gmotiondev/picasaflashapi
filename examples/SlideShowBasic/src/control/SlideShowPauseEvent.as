/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.SlideShowPauseEvent extends BasicEvent
{
	public var force:Boolean;
	
	public function SlideShowPauseEvent(f:Boolean)
	{
		super(Controller.SLIDESHOW_PAUSE_EVENT);
		
		force = f;
	}
}