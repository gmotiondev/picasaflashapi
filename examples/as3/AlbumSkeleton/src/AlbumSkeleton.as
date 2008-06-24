package  
{
	import flash.display.Sprite;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.examples.albumskeleton.view.components.AlbumView;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AlbumSkeleton extends Sprite 
	{
		public var album : AlbumView;		
		private var facade : ApplicationFacade;
		
		public function AlbumSkeleton()
		{
			initializeViews();
			
			facade = ApplicationFacade.getInstance();
			facade.startup(this);
		}
		
		private function initializeViews() : void
		{
			album = new AlbumView();
			
			this.addChild(album);
		}
	}
}
