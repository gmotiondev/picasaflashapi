package sk.prasa.tumblr.view.components 
{
	import com.bit101.components.ProgressBar;
	
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * Preloader. 
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 */
	public class PreloaderView extends Sprite 
	{
		private var indicator : ProgressBar;

		public function PreloaderView()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler, false, 0, true);
		}

		private function initializeIndicator() : void
		{
			indicator = new ProgressBar(this, 0, 0);
			indicator.maximum = 100;
			indicator.visible = false;
			
			resize();
		}
		
		private function addedToStage_Handler(evt : Event) : void
		{
			initializeIndicator();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage_Handler);
		}

		public function setProgress(value : Number) : void
		{
			indicator.visible = value >= 0 && value < 100;
			indicator.value = value;
		}
		
		public function resize() : void
		{
			this.x = 0;
			this.y = 0;
			this.indicator.setSize(this.stage.stageWidth, 4);
		}
	}
}
