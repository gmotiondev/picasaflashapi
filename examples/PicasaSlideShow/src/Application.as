import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;

import view.ViewList;
import view.PhotoHolder;
import view.Navigation;
import view.LoadingBar;
import events.EventList;
import control.Controller;
import model.ModelApplication;

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
		var tLB:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip("loadingBar",10010));
		
		Controller.getInstance().initialize();
		
		var tPH:PhotoHolder = new PhotoHolder(ViewList.PHOTO, mc.createEmptyMovieClip("photoholder",10));
		var tNAV:Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip("navigation",20));
		
		var m:ModelApplication = new ModelApplication();
			m.addEventListener(EventList.PHOTO_CLICK, tNAV);
			m.addEventListener(EventList.PHOTO_CHANGED, tNAV);
			m.setContainer(mc);
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