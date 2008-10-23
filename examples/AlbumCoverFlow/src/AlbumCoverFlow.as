package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import sk.prasa.examples.albumcoverflow.ApplicationFacade;
	import sk.prasa.examples.albumcoverflow.view.components.AlbumView;
	import sk.prasa.examples.albumcoverflow.view.components.NavigationView;
	import sk.prasa.examples.albumcoverflow.view.components.PreloaderView;
	import sk.prasa.examples.albumcoverflow.view.components.ThumbsView;		

	[SWF(width="800", height="600", backgroundColor="0x000000", frameRate="31")]
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumCoverFlow extends Sprite 
	{
		public var album : AlbumView;
		public var thumbs : ThumbsView;
		public var preloader : PreloaderView;
		public var navigation : NavigationView; 
				
		private var facade : ApplicationFacade;
		
		public function AlbumCoverFlow()
		{
			initializeStage();
			initializeViews();
			
			facade = ApplicationFacade.getInstance();
			facade.startup(this);
		}
		
		private function initializeStage() : void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		private function initializeViews() : void
		{	
			album = new AlbumView();
			thumbs = new ThumbsView();
			thumbs.x = 160; thumbs.y = 400; 
			
			preloader = new PreloaderView();
			navigation = new NavigationView();
			
			this.addChild(album);
			this.addChild(thumbs);
			this.addChild(preloader);
			this.addChild(navigation);
		}
		
		private function resizeHandler(evt : Event) : void
		{
		}
	}
}
