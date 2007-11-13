/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.MethodGroupHelper;
import sk.prasa.webapis.picasa.core.NameValuePair;

class sk.prasa.webapis.picasa.core.Photos
{
	private var __service:PicasaService;
	
	public function Photos(service:PicasaService)
	{
		__service = service;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?kind=photo
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993
	public function list(userid:String, albumid:String):Void
	{
		var tSuffix:String = ""+userid+"/albumid/"+albumid;
		var tParams:Array = [new NameValuePair("kind","photo")];
		
		MethodGroupHelper.invokeMethod(__service, Delegate.create(this, list_complete), false, tSuffix, tParams);
	}
	
	private function list_complete(e:XMLToObjectEvent):Void
	{
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
