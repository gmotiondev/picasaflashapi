import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.AlbumOpenEvent extends BasicEvent
{
	public var id : String;

	public function AlbumOpenEvent(aId : String)
	{
		super(Controller.ALBUM_OPEN_EVENT);
		
		id = aId;
	}
}
