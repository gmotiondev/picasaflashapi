/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;

class plugins.dialog.dialog extends AbstractPlugin
{	
	public function dialog()
	{
		super();
		
		initialize();
	}
	
	private function initialize():Void
	{
		trace("dialog up and running!");
	}
}