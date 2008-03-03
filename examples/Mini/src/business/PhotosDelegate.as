import com.bourre.core.Model;
import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.UrlParams;

import model.*;
import command.IResponder;
import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class business.PhotosDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function PhotosDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUserid:String, aAlbumid:String):Void
	{
		var tUrlParams:UrlParams = new UrlParams();
			tUrlParams.thumbsize = 48;
			tUrlParams.imgmax = 512;
		
		__service.addEventListener(PicasaService.PROGRESS, list_progress); 
		__service.addEventListener(PicasaResultEvent.PHOTOS_GET_LIST, Delegate.create(this, list_complete));
		__service.photos.list(aUserid, aAlbumid, tUrlParams);
	}

	public function list_complete(e:PicasaResultEvent):Void
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
	
	private function list_progress(e:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(NumberEvent(e).getNumber()));
	}
}