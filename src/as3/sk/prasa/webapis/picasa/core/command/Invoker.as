package sk.prasa.webapis.picasa.core.command 
{
	import sk.prasa.webapis.picasa.core.command.ICommand;	
	
	/**
	 * Command Invoker. Part of the Command Pattern.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class Invoker 
	{
		private var __command : ICommand;
		
		/**
		 * Store command.
		 */
		public function setCommand(command : ICommand) : void
		{
			__command = command;
		}
		
		/**
		 * Execute stored command.
		 */
		public function executeCommand() : void 
		{
			__command.execute();
		}	
	}
}