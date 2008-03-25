/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import plugins.picasa.model.*;
import plugins.picasa.control.*;
import plugins.picasa.command.IResponder;

class plugins.picasa.business.GetPhotosDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function GetPhotosDelegate(c:IResponder, s:PicasaService)
	{
		__command = c;
		__service = s;
	}
	
	public function list(aUserid:String, aAlbumid:String):Void
	{
		__service.addEventListener(PicasaService.PROGRESS, Delegate.create(this, list_progress)); 
		__service.addEventListener(PicasaResultEvent.PHOTOS_GET_LIST, Delegate.create(this, list_complete));
		__service.photos.list(aUserid, aAlbumid);
	}

	private function list_complete(e:PicasaResultEvent):Void
	{
		try
		{
			if(e.success) {
				__command.result(e.data);
			} else {
				__command.fault(e.error);
			}
		} catch(error:Error)
		{
			trace("list_complete failed: "+error.message)
		} finally
		{
			__service.removeEventListener(PicasaResultEvent.PHOTOS_GET_LIST, list_complete);
		}
	}
	
	private function list_progress(evt:NumberEvent):Void
	{
		//firePublicEvent(new NumberEvent(new EventType("onProgress"), evt.getNumber()))
		__command.progress(evt.getNumber());
	}
}