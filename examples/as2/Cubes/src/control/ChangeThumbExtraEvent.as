import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.ChangeThumbExtraEvent extends BasicEvent
{
	public function ChangeThumbExtraEvent()
	{
		super(Controller.CHANGE_THUMB_EXTRA_EVENT);
	}
}
