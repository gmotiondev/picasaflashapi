/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.NameValuePair;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;

import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

class sk.prasa.webapis.picasa.core.Albums
{
	private var __service:PicasaService;
	
	public function Albums(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID?kind=album
	public function list(userid:String, params:Array):Void
	{
		var tSuffix:String = ""+userid;
		var tParams:Array = [new NameValuePair("kind","album")];
		
		if(params != null)
		{
			for(var a:Number = 0; a < params.length; a++)
			{
				tParams.push(params[a]);
			}
		}
		
		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_complete), false, tSuffix, tParams);
	}
	
	private function list_complete(e:XMLToObjectEvent):Void
	{
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.ALBUMS_LIST);

		MethodGroupHelper.processAndDispatch(__service,
											e.getObject(),
											tResultEvent,	
											MethodGroupHelper.parseAlbumList);	
	}
}

