package control.photo 
{
	import com.bourre.events.BasicEvent;
	
	import control.Controller;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotoChangedEvent extends BasicEvent 
	{
		public var id : String;
		public var title : String;
		public var url : String;
		
		public function PhotoChangedEvent(aId : String, aTitle : String, aUrl : String)
		{
			super(Controller.PHOTO_CHANGED_EVENT);
			
			id = aId;
			title = aTitle;
			url = aUrl;
		}
	}
}
