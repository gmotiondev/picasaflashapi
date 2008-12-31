package sk.prasa.tumblr.view 
{
	import sk.prasa.tumblr.model.ContentProxy;	
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.view.components.TitleView;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class TitleMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "TitleMediator";
		
		public function TitleMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.TITLE_CHANGE_EVENT,
					ApplicationFacade.RESIZE_EVENT];
		}
		
		override public function handleNotification(note : INotification) : void
		{
			switch(note.getName())
			{
				case ApplicationFacade.TITLE_CHANGE_EVENT:
					var tCP : ContentProxy = facade.retrieveProxy(ContentProxy.NAME) as ContentProxy;
					var tTitle : String = note.getBody() as String;
					
					this.title.text = 	tCP != null ? 
										"(" + tCP.currentEntry + "/" + tCP.totalEntries + ") " + (tTitle != null ? tTitle : "") :
										tTitle;
									
					break;
					
				case ApplicationFacade.RESIZE_EVENT:
					this.title.resize();
					break;
			}
		}
		
		private function get title() : TitleView
		{
			return viewComponent as TitleView;
		}
	}
}
