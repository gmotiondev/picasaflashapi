import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoOpenEvent extends BasicEvent
{
	public var id:String;
	public var albumid : String;
	
	public function PhotoOpenEvent(aId : String, aAlbumId : String)
	{
		super(Controller.PHOTO_OPEN_EVENT);
		
		id = aId;
		albumid = aAlbumId;
	}
}
