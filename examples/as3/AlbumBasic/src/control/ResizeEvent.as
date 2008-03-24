package control 
{
	import com.bourre.events.BasicEvent;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ResizeEvent extends BasicEvent 
	{
		public function ResizeEvent()
		{
			super(Controller.RESIZE_EVENT);
		}
	}
}
