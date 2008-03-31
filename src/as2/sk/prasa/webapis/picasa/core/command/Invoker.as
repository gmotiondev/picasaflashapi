import sk.prasa.webapis.picasa.core.command.ICommand;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.command.Invoker 
{
	private var command : ICommand;

	public function setCommand(command : ICommand) : Void
	{
		this.command = command;
	}
	
	public function executeCommand() : Void 
	{
		command.execute();
	}
}
