import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;

import model.*;
import view.*;
import control.*;

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
		trace("Application up and running!");
		//var tLB:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip("loadingBar",10010));
		
		Controller.getInstance().initialize();
		
		//var tPH:PhotoHolder = new PhotoHolder(ViewList.PHOTO, mc.createEmptyMovieClip("photoholder",10));
		//var tNAV:Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip("navigation",20));
		
		var m:ModelApplication = new ModelApplication();
			m.container = mc;
			m.initialize();	
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