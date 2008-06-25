package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Sprite;

	import com.bit101.components.ProgressBar;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PreloaderView extends Sprite 
	{
		private var indicator : ProgressBar;

		public function PreloaderView()
		{
			initializeIndicator();
		}

		private function initializeIndicator() : void
		{
			indicator = new ProgressBar(this, 0, 0);
			indicator.maximum = 100;
			indicator.visible = false;
		}

		public function setProgress(aValue : Number) : void
		{
			indicator.visible = aValue >= 0 && aValue < 100;
			indicator.setSize(stage.width, 10);
			indicator.value = aValue;
		}
	}
}
