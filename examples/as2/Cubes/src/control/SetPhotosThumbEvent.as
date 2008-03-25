import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.SetPhotosThumbEvent extends BasicEvent
{
	public var albumid:String;
	
	public function SetPhotosThumbEvent(aAlbumId:String)
	{
		super(Controller.SET_PHOTOS_THUMB_EVENT);
		
		albumid = aAlbumId;
	}
}