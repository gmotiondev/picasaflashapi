package
{
	import sk.prasa.tools.model.vo.RequestVO;	import sk.prasa.tumblr.ApplicationFacade;	import sk.prasa.tumblr.view.components.*;		import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * "5094406297232552993";	// sample album
	 * "5161355527636525521";	//diana
	 */
	public class MainApplication extends Sprite
	{		
		public var album : AlbumView;
//		public var thumbs : ThumbsView;
		public var preloader : PreloaderView;
		public var title : TitleView;
		public var navigation : NavigationView; 
		public var tooltip : ToolTipView;
		public var request : RequestVO; 
		
		private var facade : ApplicationFacade;
		
		public function MainApplication()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler, false, 0, true);
		}

		private function addedToStage_Handler(evt : Event) : void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			request = new RequestVO(this.root.loaderInfo.parameters);
			
			initializeViews();
			
			facade = ApplicationFacade.getInstance();
			facade.startup(this);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler);
		}
		
		private function initializeViews() : void
		{
			album = new AlbumView();
			album.y = 0;
			
//			thumbs = new ThumbsView();
//			thumbs.width = 576;
//			thumbs.x = this.stage.stageWidth;
//			thumbs.y = 0;
				
			preloader = new PreloaderView();
			title = new TitleView(	NaN, NavigationView.NAVIGATION_HEIGHT, 
									request.font_color, request.background_color);			
			navigation = new NavigationView(
									request.font_color, request.background_color);
			//tooltip = new ToolTipView();
			
			this.addChild(album);
//			this.addChild(thumbs);
			this.addChild(preloader);
			this.addChild(title);
			this.addChild(navigation);
			//this.addChild(tooltip);
		}
	}
}
