package sk.prasa.tumblr.controller 
{
	import sk.prasa.tumblr.model.ApplicationProxy;
	import sk.prasa.tumblr.model.ServiceProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ModelPrepCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void
		{
			var app : MainApplication = note.getBody() as MainApplication;

			facade.registerProxy(new ApplicationProxy());
			facade.registerProxy(new ServiceProxy(app.request));
		}
	}
}
