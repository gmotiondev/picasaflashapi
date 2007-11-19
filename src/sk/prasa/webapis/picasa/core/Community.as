/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;
import sk.prasa.webapis.picasa.core.NameValuePair;

[Event(name="communityGetSearch", type="sk.prasa.webapis.picasa.events.PicasaResultEvent")]
	
class sk.prasa.webapis.picasa.core.Community
{
	private var __service:PicasaService;
	
	public function Community(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/all?kind=photo&q=searchTerm&max-results=10
	public function search(searchTerm:String,params:Array):Void
	{
	}
	
	private function search_complete(event:XMLToObjectEvent):Void
	{
	}
}