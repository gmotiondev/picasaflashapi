package sk.prasa.examples.albumskeleton.controller 
{
	import org.puremvc.as3.interfaces.INotification;	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PrevPageCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			trace("<<< shift to the previous page!");
		}
	}
}
