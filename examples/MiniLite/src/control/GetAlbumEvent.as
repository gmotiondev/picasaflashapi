/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.GetAlbumEvent 
{
	public var userid : String;
	public var albumid : String;
	
	public function GetAlbumEvent(aUserid : String, aAlbumId : String)
	{
		userid = aUserid;
		albumid = aAlbumId;
	}
}
