import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.InitializeAlbumsEvent extends BasicEvent
{
	public var userid:String;
	
	public function InitializeAlbumsEvent(aUserid:String)
	{
		super(Controller.INITIALIZE_ALBUMS_EVENT);
		
		userid = aUserid;
	}
}