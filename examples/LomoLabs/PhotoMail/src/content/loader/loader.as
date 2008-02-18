/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;

import com.bourre.events.EventType;
import com.bourre.events.NumberEvent;
import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

class content.loader.loader extends AbstractPlugin
{
	private var __loader:MovieClip;
	
	private function loader(mc:MovieClip)
	{		
		mc.createEmptyMovieClip("cb", 2); 
		
		mc.cb.onNameCallBack = Delegate.create(this, onNameCallback);
		mc.cb.onProgressCallback = Delegate.create(this, onProgressCallback);
		mc.cb.onBuildCallback = Delegate.create(this, onBuildCallback);
		
		__loader = Geom.buildRectangle(mc, 10005, Stage.width, 2, 0xd40073, 0xd40073);
	}
	private function onNameCallback(aLoadingName:String):Void
	{
		// trace("onNameCallback: "+aLoadingName);
	}
	
	private function onProgressCallback(aPercents:Number):Void
	{
		onProgress(new NumberEvent(new EventType("onProgress"), aPercents));
	}
	
	private function onBuildCallback():Void
	{
		// trace("onBuildCallback. ");
	}
	
	public function onProgress(evt:NumberEvent):Void
	{	 
		__loader._visible = evt.getNumber() < 100;
		__loader._xscale = 100 - evt.getNumber();
	}
	
	public static function main(mc:MovieClip):Void
	{
		var o:loader = new loader(mc);
	}
}