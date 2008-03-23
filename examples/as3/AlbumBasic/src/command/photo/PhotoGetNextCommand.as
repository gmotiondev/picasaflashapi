package command.photo 
{
	import flash.events.Event;	
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;	
	
	import control.photo.PhotoGetNextEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotoGetNextCommand extends AbstractCommand implements Command 
	{
		override public function execute(evt : Event = null) : void
		{
		}
	}
}
