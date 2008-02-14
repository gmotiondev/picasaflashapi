/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.plugin.AbstractPlugin;

import com.bourre.events.IEvent;

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
	
	public function onSendPhoto(evt:IEvent):Void
	{
		var o:Object = evt.getTarget();
		trace("onSendPhoto received by mailer, from"+o.from+"to: "+o.to+", desc: "+o.desc+", url"+o.url);
	}
}