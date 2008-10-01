import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.InitializePhotoEvent extends BasicEvent
{
	public var id : String;
	public var albumid : String;
	
	public function InitializePhotoEvent(aId : String, aAlbumId: String)
	{
		super(Controller.INITIALIZE_PHOTO_EVENT);
		
		id = aId;
		albumid = aAlbumId;
	}
}