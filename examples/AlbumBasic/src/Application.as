import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;

import uis.uilist;
import events.EventList;
import controllers.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClipHelper
{
	public function Application(mc:MovieClip)
	{
		super(uilist.APPLICATION, mc);
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{
		Controller.getInstance().initialize();
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.RUN_APPLICATION,mc));
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