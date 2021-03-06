package sk.prasa.tumblr.controller 
{
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.model.ContentProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PrevPhotoCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			if(facade.hasProxy(ContentProxy.NAME))
			{
				var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
				
				if(tContentProxy.totalEntries > 0)
				{
					this.sendNotification(ApplicationFacade.CHANGE_PHOTO_EVENT, tContentProxy.getPrevPhoto());
				}
			}
		}
	}
}
