package sk.prasa.tumblr.view 
{	import org.puremvc.as3.interfaces.INotification;	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	/**	 * @author Michal Gron (michal.gron@gmail.com)	 */	public class ErrorMediator extends Mediator implements IMediator 
	{		public function ErrorMediator(mediatorName : String = null, viewComponent : Object = null)
		{			super(mediatorName, viewComponent);		}
		
		override public function listNotificationInterests() : Array
		{			return [];
		}
		
		override public function handleNotification(notification : INotification) : void
		{		}
	}}