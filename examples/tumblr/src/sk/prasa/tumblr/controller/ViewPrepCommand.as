package sk.prasa.tumblr.controller 
{
	import sk.prasa.tumblr.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ViewPrepCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void
		{
			facade.registerMediator(new ApplicationMediator(note.getBody() as TumblrApp));
		}
	}
}
