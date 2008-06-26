package sk.prasa.examples.albumskeleton.view.components 
{
	import flash.display.Sprite;

	import com.bit101.components.Label;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class TitleView extends Sprite 
	{
		private var __title : Label;

		public function TitleView()
		{
			__title = new Label(this, 150, 0, "");
		}

		public function set text(aText : String) : void
		{
			__title.text = aText;
		}

		public function get text() : String
		{
			return __title.text;
		}
	}
}
