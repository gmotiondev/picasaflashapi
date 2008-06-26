package sk.prasa.examples.albumskeleton.view.components 
{
	import com.yahoo.astra.layout.LayoutContainer;
	import com.yahoo.astra.layout.modes.FlowLayout;
	import com.yahoo.astra.layout.modes.ILayoutMode;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ThumbsView extends LayoutContainer 
	{
		public static var HORIZONTAL_GAP : Number = 2;
		public static var VERTICAL_GAP : Number = 2;
		
		public function ThumbsView(mode : ILayoutMode = null)
		{
			super(mode);
			
			var tThumbsLayoutMode : FlowLayout = new FlowLayout();
				tThumbsLayoutMode.horizontalGap = HORIZONTAL_GAP;
				tThumbsLayoutMode.verticalGap = VERTICAL_GAP;
			
			this.layoutMode = tThumbsLayoutMode;
		}
	}
}
