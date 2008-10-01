import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.SetAlbumsThumbEvent extends BasicEvent
{
	public function SetAlbumsThumbEvent()
	{
		super(Controller.SET_ALBUMS_THUMB_EVENT);
	}
}
