package sk.prasa.examples.albumskeleton.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.model.ContentProxy;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class NextPhotoCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
			var tNextID : String = tContentProxy.getNextPhoto();
			
			this.sendNotification(ApplicationFacade.CHANGE_PHOTO_EVENT, tNextID);
		}
	}
}
