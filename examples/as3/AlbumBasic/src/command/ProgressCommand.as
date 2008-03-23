package command 
{
	import flash.events.Event;	
	
	import com.bourre.commands.Command;	
	import com.bourre.commands.AbstractCommand;	
	
	import control.ProgressEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ProgressCommand extends AbstractCommand implements Command 
	{
		override public function execute(evt : Event = null) : void
		{
		}
	}
}
