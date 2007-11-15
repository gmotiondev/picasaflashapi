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
		/* model */
		var model:ModelApplication = new ModelApplication();
		
		/* views, SHOULD LISTEN TO MODEL! */
		var l_view:LoadingBar = new LoadingBar(ViewList.LOADING_BAR, mc.createEmptyMovieClip("loadingBar",10010));
		var p_view:PhotoHolder= new PhotoHolder(ViewList.PHOTO_HOLDER, mc.createEmptyMovieClip("photoholder",10));
		var n_view:Navigation = new Navigation(ViewList.NAVIGATION, mc.createEmptyMovieClip("navigation",20));
		
		/* controller */
		Controller.getInstance().initialize();
		model.addListener(p_view);
		model.container = mc;
		model.initialize();	
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