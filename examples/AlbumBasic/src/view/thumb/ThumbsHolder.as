package view.thumb 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.load.LoaderEvent;
	import com.bourre.load.LoaderListener;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	import com.somerandomdude.tres.ui.organizers.GridOrganizer;
	import com.somerandomdude.tres.ui.organizers.ILayoutOrganizer;
	
	import control.ProgressEvent;
	import control.photo.PhotoChangedEvent;
	
	import gs.TweenLite;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ThumbsHolder extends AbstractView implements LoaderListener
	{
		private var __organizer : ILayoutOrganizer;

		public function ThumbsHolder(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc );
			
			initialize();
		}

		private function initialize() : void
		{
			move(324, 24);
			
			__organizer = new GridOrganizer(view as Sprite, 408, 408, 6, 6);
			__organizer.autoAdjustLayout = false;
		}
		
		public function addChild(child : Thumb) : void
		{
			DisplayObjectContainer(view).addChild(child);
			addListener(child);
				
			__organizer.addToLayout(child, true, true);
		}
		
		public function onLoadStart( e : LoaderEvent ) : void
		{
		}

		public function onLoadInit( e : LoaderEvent ) : void
		{
			var tItem : Sprite = Sprite(e.getTarget().getView());
				tItem.alpha = 0;
				tItem.scaleX = 0.5;
				tItem.scaleY = 0.5;
				tItem.x = tItem.width/2;
				tItem.y = tItem.height/2;				 
				
			TweenLite.to(tItem, 0.5, {alpha:1, scaleX:1, scaleY:1, x:0, y:0});
		}
		
		public function onLoadProgress( e : LoaderEvent ) : void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(e.getPerCent()));
		}

		public function onLoadTimeOut( e : LoaderEvent ) : void
		{
		}
		
		public function onLoadError( e : LoaderEvent ) : void
		{
		}
		
		public function photo_changed_event(evt : PhotoChangedEvent) : void
		{
			notifyChanged(evt);
		}
	}
}
