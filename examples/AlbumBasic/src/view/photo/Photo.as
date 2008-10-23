package view.photo 
{
	import com.bourre.events.StringEvent;	
	import com.bourre.view.ViewListener;	
	
	import gs.TweenLite;	
	
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.load.GraphicLoader;
	import com.bourre.load.LoaderEvent;
	import com.bourre.load.LoaderListener;
	
	import control.ProgressEvent;
	import control.photo.PhotoChangedEvent;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Photo extends Sprite implements LoaderListener, ViewListener
	{
		private var id : String;
		private var loaded : Boolean = false;

		public function Photo(aId : String)
		{
			id = aId;
			y = 24;
		}
		
		private function load(aUrl : String) : void
		{
			var tGL : GraphicLoader = new GraphicLoader(this);
				tGL.addListener(this);
				tGL.load(new URLRequest("http://prasa.sk/image.php?image="+aUrl));
		}
		
		private function show() : void
		{
			visible = true;
		}
		
		private function hide() : void
		{
			visible = false;
		}
		
		public function onInitView(e : StringEvent) : void {}
		public function onReleaseView(e : StringEvent) : void {}
		
		public function onLoadStart( e : LoaderEvent ) : void
		{
		}
		
		public function onLoadInit( e : LoaderEvent ) : void
		{
			loaded = true;
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
			if(evt.id == id)
			{
				if(!loaded) load(evt.url);
				
				show();
				alpha = 0;
				TweenLite.to(this, 0.5, {alpha:1});
				
			} else
			{
				if(visible)
				{
					TweenLite.to(this, 0.5, {alpha:0, onComplete : hide});
				}
			}
		}
	}
}
