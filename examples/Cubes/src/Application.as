import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;

import view.ViewList;
import view.CubeView;
import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{	
		trace("Up and running!");
		
		Controller.getInstance().initialize();
		
		var tCube:CubeView = new CubeView(ViewList.CUBE, mc.createEmptyMovieClip("cube",10));
		//var m:ModelApplication = new ModelApplication();
		//	m.addEventListener(EventList.PHOTO_CLICK, tNAV);
		//	m.initialize();
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}