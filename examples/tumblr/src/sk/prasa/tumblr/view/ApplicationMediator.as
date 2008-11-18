package sk.prasa.tumblr.view 
{
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import sk.prasa.tumblr.ApplicationFacade;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com) 
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "ApplicationMediator";

		public function ApplicationMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
			
			facade.registerMediator(new AlbumMediator(app.album));
//			facade.registerMediator(new ThumbsMediator(app.thumbs));
			facade.registerMediator(new PreloaderMediator(app.preloader));
			facade.registerMediator(new TitleMediator(app.title));
			facade.registerMediator(new NavigationMediator(app.navigation));
			facade.registerMediator(new ToolTipMediator(app.tooltip));
		}
		
		override public function onRegister() : void
		{
			this.sendNotification(ApplicationFacade.LOAD_EVENT);
			
			this.app.stage.addEventListener(Event.RESIZE, resize_Handler, false, 0, true);
			this.app.stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullScreen_Handler, false, 0, true);
		}

		override public function listNotificationInterests() : Array 
		{
			return [];
		}

		override public function handleNotification(note : INotification) : void 
		{
		}
		
		private function resize_Handler(evt : Event) : void
		{
			this.sendNotification(ApplicationFacade.RESIZE_EVENT);
		}
		
		private function fullScreen_Handler(evt : FullScreenEvent) : void
		{
			this.sendNotification(ApplicationFacade.FULLSCREEN_EVENT, evt.fullScreen);
		}
		
		protected function get app() : MainApplication
		{
			return viewComponent as MainApplication;
		}
	}
}
