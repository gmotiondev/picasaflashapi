import com.bourre.core.Model;
import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.mvc.command.IResponder;

import model.*;
import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class business.PhotosDelegate
{
	private var __c : IResponder;
	private var __s : PicasaService;
	
	public function PhotosDelegate(command : IResponder)
	{
		__c = command;
		__s = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUserid : String, aAlbumid : String) : Void
	{
		var p : UrlParams = new UrlParams();
			p.thumbsize = 48;
			p.imgmax = 512;
		
		__s.addEventListener(PicasaService.PROGRESS, list_progress); 
		__s.addEventListener(PicasaResultEvent.PHOTOS_GET_LIST, Delegate.create(this, list_complete));
		__s.photos.list(aUserid, aAlbumid, p);
	}

	public function list_complete(evt : PicasaResultEvent) : Void
	{
		try
		{
			if(evt.success) {
				__c.result(evt.data);
			} else {
				__c.fault(evt.error);
			}
		} catch(error : Error)
		{
			trace("list_complete failed: " + error.message);
		} finally
		{
			__s.removeEventListener(PicasaResultEvent.PHOTOS_GET_LIST, list_complete);
		}
	}
	
	private function list_progress(evt : NumberEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getNumber()));
	}
}