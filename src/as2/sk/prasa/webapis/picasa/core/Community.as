import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.command.*;
import sk.prasa.webapis.picasa.core.receiver.*;
import sk.prasa.webapis.picasa.core.receiver.community.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

[Event(name="communityGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
class sk.prasa.webapis.picasa.core.Community
{
	/**
	 * List photos in community by given query 
	 * Loads e.g. http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm
	 * 
	 * @param query String Query
	 * @param params String Params to alter the feed url
	 */
	public function search(query : String, params : UrlParams) : Void
	{
		var s : String = "all";
		var p : UrlParams = PicasaService.getInstance().mergeUrlParams(params);
			p.kind = "photo";	// override!
			p.tag = null;
			p.q = query;

		var tReceiver : IReceiver = new CommunitySearchReceiver();
		var tCommand : ICommand = new GetFeedCommand(tReceiver, s, p.toString());
		var tInvoker : Invoker = new Invoker();
		
		tInvoker.setCommand(tCommand);
		tInvoker.executeCommand();
	}
}