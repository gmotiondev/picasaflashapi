package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.core.command.ICommand;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	internal class Invoker 
	{
		private var command : ICommand;

		public function setCommand(command : ICommand) : void
		{
			this.command = command;
		}
		
		public function executeCommand() : void 
		{
			command.execute();
		}	
	}
}
