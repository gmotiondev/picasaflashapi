package sk.prasa.tumblr.controller 
{
	import sk.prasa.tumblr.model.ContentProxy;	
	import sk.prasa.tumblr.ApplicationFacade;	
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ErrorCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void
		{
			if(facade.hasProxy(ContentProxy.NAME))
			{
				facade.removeProxy(ContentProxy.NAME);
			}
			
			// register a empty content proxy!
			facade.registerProxy(new ContentProxy());
			
			var tError : String = note.getBody() as String;
			
			this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, "Error loading feed! " + tError);
		}
	}
}
