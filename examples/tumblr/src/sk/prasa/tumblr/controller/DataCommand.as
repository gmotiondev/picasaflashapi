package sk.prasa.tumblr.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.model.ContentProxy;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class DataCommand extends SimpleCommand implements ICommand 
	{	
		override public function execute(notification : INotification) : void
		{
			if(facade.hasProxy(ContentProxy.NAME))
			{
				facade.removeProxy(ContentProxy.NAME);
			}
			
			var tContentProxy : ContentProxy = new ContentProxy(notification.getBody());
			
			if(tContentProxy.getEntries().length > 0)
			{
				facade.registerProxy(new ContentProxy(notification.getBody()));
			
				this.sendNotification(ApplicationFacade.CHANGE_THUMBS_EVENT);
				
			} else
			{
				this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, "Sorry, no results!");
				this.sendNotification(ApplicationFacade.PROGRESS_EVENT, 100);
			}
		}
	}
}
