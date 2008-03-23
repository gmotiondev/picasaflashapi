package command.photo 
{
	import flash.events.Event;	
	
	import com.bourre.commands.Command;
	import com.bourre.commands.AbstractCommand;	
	
	import control.photo.PhotoGetPrevEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotoGetPrevCommand extends AbstractCommand implements Command 
	{
		override public function execute(evt : Event = null) : void
		{
		}
	}
}
