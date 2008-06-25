package sk.prasa.examples.albumskeleton.view 
{
	import sk.prasa.examples.albumskeleton.ApplicationFacade;	
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "ApplicationMediator";

		public function ApplicationMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
			
			facade.registerMediator(new AlbumMediator(app.album));
			facade.registerMediator(new PreloaderMediator(app.preloader));
		}

		override public function listNotificationInterests() : Array 
		{
			return [ApplicationFacade.RESIZE_EVENT, 
					ApplicationFacade.FULLSCREEN_EVENT];
		}

		override public function handleNotification(notification : INotification) : void 
		{
			switch (notification.getName()) 
			{
				case ApplicationFacade.RESIZE_EVENT : break;				case ApplicationFacade.FULLSCREEN_EVENT : break;
				default : break;
			}
		}
		
		protected function get app() : AlbumSkeleton
		{
			return viewComponent as AlbumSkeleton;
		}
	}
}
