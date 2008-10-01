import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoCloseEvent extends BasicEvent
{
	public var id:String;
	public var albumid : String;
	
	public function PhotoCloseEvent(aId : String, aAlbumId : String)
	{
		super(Controller.PHOTO_CLOSE_EVENT);
		
		id = aId;
		albumid = aAlbumId;
	}
}
