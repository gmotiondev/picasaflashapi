/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.SlideShowStartEvent extends BasicEvent
{
	public function SlideShowStartEvent()
	{
		super(Controller.SLIDESHOW_START_EVENT);
	}
}