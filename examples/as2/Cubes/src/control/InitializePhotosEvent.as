import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.InitializePhotosEvent extends BasicEvent
{
	public var userid : String;
	public var albumid : String;

	public function InitializePhotosEvent(aUserid : String, aAlbumid : String)
	{
		super(Controller.INITIALIZE_PHOTOS_EVENT);
		
		userid = aUserid;
		albumid = aAlbumid;
	}
}