package sk.prasa.examples.albumskeleton.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import sk.prasa.examples.albumskeleton.model.ApplicationProxy;
	import sk.prasa.examples.albumskeleton.model.ServiceProxy;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ModelPrepCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			facade.registerProxy(new ApplicationProxy());
			facade.registerProxy(new ServiceProxy());
		}
	}
}
