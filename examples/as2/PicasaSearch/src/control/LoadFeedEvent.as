import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.LoadFeedEvent extends BasicEvent
{
	public var query : String;

	public function LoadFeedEvent(q : String)
	{
		super(Controller.LOAD_FEED_EVENT);
		
		query = q;
	}
}