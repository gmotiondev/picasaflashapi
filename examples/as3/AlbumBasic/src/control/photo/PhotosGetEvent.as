package control.photo 
{
	import com.bourre.events.BasicEvent;
	
	import control.Controller;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosGetEvent extends BasicEvent 
	{
		public var userid : String;
		public var albumid : String;
		
		public function PhotosGetEvent(aUserid : String, aAlbumid : String)
		{
			super(Controller.PHOTOS_GET_EVENT);
			
			userid = aUserid;
			albumid = aAlbumid;
		}
	}
}
