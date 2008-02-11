/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;

class plugins.mailer.mailer extends AbstractPlugin
{
	public function mailer()
	{
		super();
		
		initialize();
	}
	
	private function initialize():Void
	{
		trace("mailer up and running!");
	}
}