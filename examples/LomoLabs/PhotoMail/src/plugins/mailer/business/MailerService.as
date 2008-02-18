/**
 * @author michal.gron@gmail.com
 */

import com.bourre.remoting.ServiceProxyLocator;
import com.bourre.remoting.ServiceProxy;

class plugins.mailer.business.MailerService extends ServiceProxyLocator
{
	private static var __instance:MailerService;
	
	public static function getInstance():MailerService
	{
		if(!__instance)
		{
			__instance = new MailerService();
		}
		
		return __instance;
	}
	
	private function MailerService()
	{
		super();
		
		gatewayURL = "http://amf.prasa.sk/gateway.php";		
		push("Mailer", new ServiceProxy(gatewayURL, "Mailer"));
	}
}