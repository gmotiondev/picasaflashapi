package view.photo 
{
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
	
	public class Photo extends Sprite implements LoaderListener
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
				visible = true;
			} else
			{
				if(visible)
				{
					visible = false;
				}
			}
		}
	}
}
