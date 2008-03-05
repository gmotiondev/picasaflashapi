/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.LoadPhotoEvent 
{
	public var id : String;
	public var url : String;
	
	public function LoadPhotoEvent(aId : String, aUrl : String)
	{
		id = aId;
		url = aUrl;
	}
}
