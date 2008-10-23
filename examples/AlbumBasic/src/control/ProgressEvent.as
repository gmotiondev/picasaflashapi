package control 
{
	import com.bourre.events.BasicEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ProgressEvent extends BasicEvent 
	{
		public var percent : int;
		
		public function ProgressEvent(p : int)
		{
			super(Controller.PROGRESS_EVENT);
			
			percent = p;
		}
	}
}
