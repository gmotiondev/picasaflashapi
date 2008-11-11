package sk.prasa.tumblr.view 
{
	import sk.prasa.tumblr.ApplicationFacade;
	import sk.prasa.tumblr.model.vo.ToolTipVO;
	import sk.prasa.tumblr.view.components.ToolTipView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ToolTipMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "ToolTipMediator";
		
		public function ToolTipMediator(viewComponent : Object = null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.THUMB_MOUSE_OVER,
					ApplicationFacade.THUMB_MOUSE_OUT];
		}
		
		override public function handleNotification(note : INotification) : void
		{	
			switch(note.getName())
			{
				case ApplicationFacade.THUMB_MOUSE_OVER:
					
					var tVO : ToolTipVO = note.getBody() as ToolTipVO;
					this.tooltip.draw(tVO.position, tVO.text);
					
					break;
					
				case ApplicationFacade.THUMB_MOUSE_OUT:
					
					this.tooltip.clear();
					break;
			}
		}
		
		private function get tooltip() : ToolTipView
		{
			return viewComponent as ToolTipView;
		}
	}
}
