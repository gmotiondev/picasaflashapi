package  
{
	import sk.prasa.examples.albumskeleton.view.components.ThumbsView;	
	import sk.prasa.examples.albumskeleton.view.components.NavigationView;	
	import sk.prasa.examples.albumskeleton.view.components.TitleView;	
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
		public var thumbs : ThumbsView;
		public var preloader : PreloaderView;
		public var title : TitleView;
		public var navigation : NavigationView; 
		
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
			
			thumbs = new ThumbsView();
			thumbs.width = 360;
			thumbs.x = 320;
			
			preloader = new PreloaderView();
			title = new TitleView();
			navigation = new NavigationView();
			
			this.addChild(album);
			this.addChild(thumbs);
			this.addChild(preloader);
			this.addChild(title);
			this.addChild(navigation);
		}
	}
}
