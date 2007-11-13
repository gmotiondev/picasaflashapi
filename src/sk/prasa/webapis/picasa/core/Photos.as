/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.IEvent; 
import com.bourre.data.libs.XMLToObjectEvent;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;
import sk.prasa.webapis.picasa.core.NameValuePair;

class sk.prasa.webapis.picasa.core.Photos
{
	private var __service;
	
	public function Photos(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=photo
	public function list(userid:String, albumid:String):Void
	{
		var tParams:Array = [];
			tParams.push(new NameValuePair("kind","photo"));
		
		MethodGroupHelper.invokeMethod(__service, list_complete, false, tParams);
	}
	
	private function list_complete(e:XMLToObjectEvent):Void
	{
		//TODO! if is string, length != 0? doesnt have id.. its error
		trace("list_complete: "+e.getObject().id);
		trace("list_complete: "+e.getTarget().getContent().toString());
		
		for(var key in e.getObject())
		{
			trace(key+"/"+e.getObject()[key]);
		}
		var tResultEvent:PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.PHOTOS_LIST);
			
		MethodGroupHelper.processAndDispatch(__service,
											e.getObject(), 
											tResultEvent,	
											MethodGroupHelper.parsePhotoList);	
	}
	
	// http://picasaweb.google.com/data/feed/projection/all?kind=photo&q=searchTerm
	public function search(searchTerm:String):Void
	{
	
	}
}
