package  
{
	import sk.prasa.examples.albumskeleton.view.components.PreloaderView;	
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.view.components.AlbumView;		

	[SWF(width="320", height="260", backgroundColor="0xffffff", frameRate="31")]
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumSkeleton extends Sprite 
	{
		public var album : AlbumView;
		public var preloader : PreloaderView;
		 		
		private var facade : ApplicationFacade;
		
		public function AlbumSkeleton()
		{
			initializeStage();
			initializeViews();
			
			facade = ApplicationFacade.getInstance();
			facade.startup(this);
		}
		
		private function initializeStage() : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function initializeViews() : void
		{
			album = new AlbumView();
			preloader = new PreloaderView();
			
			this.addChild(album);
			this.addChild(preloader);
		}
	}
}
