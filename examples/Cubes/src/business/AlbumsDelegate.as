import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.NumberEvent;

import command.IResponder;

import model.*;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class business.AlbumsDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function AlbumsDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUserid:String):Void
	{
		__service.addEventListener(PicasaService.PROGRESS, Delegate.create(this, list_progress)); 
		__service.addEventListener(PicasaResultEvent.ALBUMS_GET_LIST, Delegate.create(this, list_complete));
		__service.albums.list(aUserid);
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
			trace("list_complete failed: "+error.message);
		} finally
		{
			__service.removeEventListener(PicasaResultEvent.ALBUMS_GET_LIST, list_complete);
		}
	}
	
	private function list_progress(e:NumberEvent):Void
	{
		//EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(NumberEvent(e).getNumber()));
	}
}