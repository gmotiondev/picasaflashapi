package view.photo 
{
	import flash.display.DisplayObject;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Photo extends AbstractView 
	{
		public function Photo(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc);
		}
	}
}
