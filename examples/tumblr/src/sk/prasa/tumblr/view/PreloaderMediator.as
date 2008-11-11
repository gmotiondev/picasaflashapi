package sk.prasa.tumblr.view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.view.components.PreloaderView;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PreloaderMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "PreloaderMediator";
		
		public function PreloaderMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.PROGRESS_EVENT,
					ApplicationFacade.RESIZE_EVENT];
		}
		
		override public function handleNotification(notification : INotification) : void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.PROGRESS_EVENT:
					this.preloader.setProgress(notification.getBody() as int);
					break;
					
				case ApplicationFacade.RESIZE_EVENT:
					this.preloader.resize();
					break;
			}
		}
		
		private function get preloader() : PreloaderView
		{
			return viewComponent as PreloaderView;
		}
	}
}
