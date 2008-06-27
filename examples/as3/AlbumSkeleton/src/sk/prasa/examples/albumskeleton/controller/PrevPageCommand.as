package sk.prasa.examples.albumskeleton.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import sk.prasa.examples.albumskeleton.model.ContentProxy;
	import sk.prasa.examples.albumskeleton.model.ServiceProxy;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PrevPageCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(notification : INotification) : void
		{
			trace("<<< shift to the previous page!");
			
			var tServiceProxy : ServiceProxy = facade.retrieveProxy(ServiceProxy.NAME) as ServiceProxy;
			var tContentProxy : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
			var tPrevPageURL : String = tContentProxy.getPrevPageURL();
			
			tServiceProxy.getCustomQuery(tPrevPageURL);
		}
	}
}
