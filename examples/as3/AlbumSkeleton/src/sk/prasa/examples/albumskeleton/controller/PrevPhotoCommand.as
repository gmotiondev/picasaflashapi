package sk.prasa.examples.albumskeleton.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.model.ContentProxy;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PrevPhotoCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
			var tPrevID : String = tContentProxy.getPrevPhoto();
			
			this.sendNotification(ApplicationFacade.CHANGE_PHOTO_EVENT, tPrevID);
		}
	}
}
