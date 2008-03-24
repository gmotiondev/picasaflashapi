package control 
{
	import com.bourre.events.BasicEvent;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class InitializeEvent extends BasicEvent 
	{
		public function InitializeEvent()
		{
			super(Controller.INITIALIZE_EVENT);
		}
	}
}
