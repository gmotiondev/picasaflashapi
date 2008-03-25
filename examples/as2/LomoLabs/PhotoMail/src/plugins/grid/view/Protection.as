/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.visual.ScreenProtection;
import com.bourre.ioc.visual.MovieClipHelperLocator;

import plugins.grid.control.ProtectionEvent;

class plugins.grid.view.Protection extends AbstractMovieClipHelper
{
	public function Protection(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);
	}
	
	public function protect():Void
	{
		var tProtection:ScreenProtection = new ScreenProtection(getOwner(), view, 5, "protection_area");
			tProtection.view._alpha = 20;
	}
	
	public function unprotect():Void
	{
		var tProtection = MovieClipHelperLocator.getInstance(getOwner()).getMovieClipHelper("protection_area");
			tProtection.release();
	}
	
	public function protection_event(evt:ProtectionEvent):Void
	{
		if(!evt.protect)
		{
			unprotect();
		} else {
			protect();
		}
	}
}