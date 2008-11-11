package sk.prasa.tumblr.view 
{
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.view.components.NavigationView;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class NavigationMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "NavigationMediator";
		
		public function NavigationMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
			
			navigation.addEventListener(NavigationView.PREV_PHOTO_EVENT, onPrevPhoto);
			navigation.addEventListener(NavigationView.NEXT_PHOTO_EVENT, onNextPhoto);
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.RESIZE_EVENT];
		}
		
		override public function handleNotification(note : INotification) : void
		{
			switch(note.getName())
			{
				case ApplicationFacade.RESIZE_EVENT:
					this.navigation.resize();
					break;
			}
		}
		
		private function onPrevPhoto(evt : Event) : void
		{
			this.sendNotification(ApplicationFacade.PREV_PHOTO_EVENT);
		}
		
		private function onNextPhoto(evt : Event) : void
		{
			this.sendNotification(ApplicationFacade.NEXT_PHOTO_EVENT);
		}
		
		private function get navigation() : NavigationView
		{
			return viewComponent as NavigationView;
		}
	}
}
