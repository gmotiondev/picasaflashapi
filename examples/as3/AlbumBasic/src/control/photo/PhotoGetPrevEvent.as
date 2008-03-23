package control.photo 
{
	import com.bourre.events.BasicEvent;	
	
	import control.Controller;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotoGetPrevEvent extends BasicEvent 
	{
		public function PhotoGetPrevEvent()
		{
			super(Controller.PHOTO_GET_PREV_EVENT);
		}
	}
}
