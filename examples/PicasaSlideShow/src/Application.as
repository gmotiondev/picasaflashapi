import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.utils.Geom;

import uis.uilist;
import events.EventList;
import controllers.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClipHelper
{
	private static var CONFIG_LOADER:MovieClip;
	
	public function Application(mc:MovieClip)
	{
		super(uilist.APPLICATION, mc);
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{
		buildConfigLoader();
		Controller.getInstance().initialize();
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.RUN_APPLICATION,mc));
	}
	
	private function buildConfigLoader():Void
	{
		CONFIG_LOADER = Geom.buildRectangle(view, 10005, Stage.width, 4, 0xffffff, 0xffffff);
	}
	
	private static function disableConfigLoader() : Void
	{
		Application.CONFIG_LOADER._visible = false;
	}
	private static function enableConfigLoader() : Void
	{
		Application.CONFIG_LOADER._visible = true;
	}
	
	public static function setConfigLoaderProgress(aPercent:Number):Void
	{
		if(aPercent == 100)
		{
			Application.disableConfigLoader();
		} else {
			Application.enableConfigLoader();
		}
		Application.CONFIG_LOADER._xscale = 100 - aPercent;
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