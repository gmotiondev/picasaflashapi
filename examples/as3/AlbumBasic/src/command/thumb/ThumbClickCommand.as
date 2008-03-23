package command.thumb 
{
	import flash.events.Event;	
	
	import com.bourre.commands.Command;	
	import com.bourre.commands.AbstractCommand;		
	
	import control.thumb.ThumbClickEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ThumbClickCommand extends AbstractCommand implements Command 
	{
		override public function execute(evt : Event = null) : void
		{
		}
	}
}
