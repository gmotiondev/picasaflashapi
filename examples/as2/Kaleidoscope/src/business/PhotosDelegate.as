import com.bourre.core.Model;
import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaEvent;

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
	
	public function list(aUserid:String, aTag:String):Void
	{
		__service.addEventListener(PicasaService.PROGRESS, Delegate.create(this, list_progress)); 
		__service.addEventListener(PicasaEvent.ALBUMS_GET_LIST_BY_TAG, Delegate.create(this, list_complete));
		__service.albums.list_by_tag(aUserid, aTag);
	}

	public function list_complete(e : PicasaEvent) : Void
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
			__service.removeEventListener(PicasaEvent.ALBUMS_GET_LIST_BY_TAG, list_complete);
		}
	}
	
	private function list_progress(e:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(NumberEvent(e).getNumber()));
	}
}