package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.bit101.components.PushButton;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumView extends Sprite 
	{
		public static const GET_ALBUM_CONTENT_EVENT : String = "get_album_content_event";
		
		public function AlbumView()
		{
			initialize();
		}
		
		private function initialize() : void
		{
			var tButton : PushButton = new PushButton();
				tButton.label = "get album content";
				tButton.addEventListener(MouseEvent.CLICK, click);
			
			this.addChild(tButton);
		}
		
		private function click(evt : MouseEvent) : void
		{
			this.dispatchEvent(new Event(GET_ALBUM_CONTENT_EVENT));
		}
	}
}
