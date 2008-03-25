/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;

import plugins.picasa.control.Controller;

class plugins.picasa.control.GetPhotosEvent extends BasicEvent
{
	public var callback:String;
	public var user:String;
	public var album:String;
	
	public function GetPhotosEvent(aCallbackChannel:String, aUser:String, aAlbum:String)
	{
		super(Controller.GET_PHOTOS_EVENT);
		
		callback = aCallbackChannel;
		user = aUser;
		album = aAlbum;
	}
}