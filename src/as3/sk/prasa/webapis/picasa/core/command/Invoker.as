package sk.prasa.webapis.picasa.core.command 
{
	import sk.prasa.webapis.picasa.core.command.ICommand;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class Invoker 
	{
		private var __command : ICommand;

		public function setCommand(command : ICommand) : void
		{
			__command = command;
		}
		
		public function executeCommand() : void 
		{
			__command.execute();
		}	
	}
}