package view.thumb 
{
	import flash.display.DisplayObject;
	
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;

	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Thumb extends AbstractView 
	{
		public function Thumb(owner : Plugin, name : String, mc : DisplayObject)
		{
			super( owner, name, mc);
		}
	}
}
