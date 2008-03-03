import control.Controller;

import com.bourre.events.BasicEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.GetAlbumEvent extends BasicEvent
{
	public var userid : String;
	public var albumid : String;
	
	public function GetAlbumEvent(aUserid : String, aAlbumId : String)
	{
		super(Controller.GET_ALBUM_EVENT);
		
		userid = aUserid;
		albumid = aAlbumId;
	}
}