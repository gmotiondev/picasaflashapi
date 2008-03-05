/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class control.PhotoChangedEvent 
{
	public var id : String;
	public var title : String;
	
	public function PhotoChangedEvent(aId : String, aTitle : String)
	{
		id = aId;
		title = aTitle;
	}
}
