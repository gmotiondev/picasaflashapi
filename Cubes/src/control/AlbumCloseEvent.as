import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.AlbumCloseEvent extends BasicEvent
{
	public var id : String;
	
	public function AlbumCloseEvent(aId : String)
	{
		super(Controller.ALBUM_CLOSE_EVENT);
		
		id = aId;
	}
}
